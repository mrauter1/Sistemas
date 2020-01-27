from __future__ import print_function
import sys
import pickle
import os.path
from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request
import datetime

import pymssql

# If modifying these scopes, delete the file token.pickle.
SCOPES = ['https://www.googleapis.com/auth/spreadsheets']

# The ID and range of a sample spreadsheet.
SAMPLE_SPREADSHEET_ID = '1S9cYxE87OTKjCSYxSWDsD1Vz3oaHpR9XicMc-S_GSQg'
#SAMPLE_RANGE_NAME = 'EMBALAGENS'

class LeitorLista:
    sheet = None
    icmPisCofins=0
    lucroBruto=0
    impostoFaturamento=0
    nomeLista='ND'
    
    def InicializarPlanilha(self):
        creds = None
        # The file token.pickle stores the user's access and refresh tokens, and is
        # created automatically when the authorization flow completes for the first
        # time.
        if os.path.exists('token.pickle'):
            with open('token.pickle', 'rb') as token:
                creds = pickle.load(token)
        # If there are no (valid) credentials available, let the user log in.
        if not creds or not creds.valid:
            if creds and creds.expired and creds.refresh_token:
                creds.refresh(Request())
            else:
                flow = InstalledAppFlow.from_client_secrets_file(
                    'credentials.json', SCOPES)
                creds = flow.run_local_server()
            # Save the credentials for the next run
            with open('token.pickle', 'wb') as token:
                pickle.dump(creds, token)
                
        service = build('sheets', 'v4', credentials=creds)
    
        # Call the Sheets API
        self.sheet = service.spreadsheets()    

    def writeCellValue(self, cell, value):
        values = [[value],]
        Body = {
			'values' : values,
			'majorDimension' : 'ROWS',
        }
        result = self.sheet.values().update(spreadsheetId=SAMPLE_SPREADSHEET_ID,
                                range=cell, valueInputOption='RAW', body=Body).execute()
        if not result:
            return 0
        else:
            return result.get('updatedCells')
    
    def readCellValue(self, cell):
        result = self.sheet.values().get(spreadsheetId=SAMPLE_SPREADSHEET_ID,
                                range=cell).execute()
        return result.get('values', [])[0][0]    
    
    def FazerLeitura(self):
        print('Inicio, lista '+self.nomeLista)
	
        self.InicializarPlanilha()
		
        #Grava ND no campo estado Faz com que todos os impostos fiquem zerados        
        self.writeCellValue('ESTADO', self.nomeLista.upper()) 
        
        #Grava a data e a hora da ultima leitura
        self.writeCellValue('DATALEITURA', datetime.datetime.today().strftime('%d/%m/%Y %H:%M:%S')) 
             
        self.icmPisCofins = float(self.readCellValue('IcmPisCofins').replace('%', ''))/100.00
        print('IcmPisCofins: '+str(self.icmPisCofins))
        
        self.lucroBruto = float(self.readCellValue('LucroBruto').replace('%', ''))/100.00
        print('LucroBruto: '+str(self.lucroBruto))        
        
        self.impostoFaturamento = float(self.readCellValue('IMPOSTOFAT').replace('%', ''))/100.00
        print('ImpostoFaturamento: '+str(self.impostoFaturamento))           
        
        RangeListaPrecos = self.readCellValue('RANGEPRECOS')
        print('%s', RangeListaPrecos)
    	
        result = self.sheet.values().get(spreadsheetId=SAMPLE_SPREADSHEET_ID,
                                   range=RangeListaPrecos).execute()
        values = result.get('values', [])
    
        if not values:
            print('No data found.')
            return None

        print('Cod, Produto, Materia Prima, Kg, Litro, 200L c/emb, 200L s/emb, 50L, 18L, 5L, 0,9L, Dens.')
        for row in values:
            if (len(row) >= 11):
                if row[0]:
                    print('%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s' % 
                         (row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9],row[10],row[12]))        
        self.GravaListaNoBanco(values)        

    def GravaListaNoBanco(self, values):      
        conn = pymssql.connect(host=r'10.0.0.201', port=1433, user=r'user', password=r'28021990', database=r'logistec')
        cursor = conn.cursor()
        
        sqlLog= """
        insert into loglistapreco (nomeLista, dataleitura, icmPisCofins, lucrobruto, impostofaturamento)  values ('{nomeLista}', '{dataleitura}', {lucrobruto:.4f}, {lucrobruto:.4f}, {impostofaturamento:.4f})
        """.format(nomeLista=self.nomeLista, dataleitura=datetime.datetime.today().strftime('%Y/%m/%d %H:%M:%S'), 
                   icmPisCofins=self.icmPisCofins, lucrobruto=self.lucroBruto, impostofaturamento=self.impostoFaturamento)
        cursor.execute(sqlLog)        
        conn.commit()
        
        cursor.execute('select @@IDENTITY')
        IDLog = cursor.fetchone()[0]
        cursor.fetchall()
        
        def GravaPreco(IDLog, CodGrupo, CodAplicacao, ComEmbalagem, Preco, temIPI):     
            Preco = Preco.replace(',', '')
            
            CodGrupo = CodGrupo.zfill(7)
            CodAplicacao = CodAplicacao.zfill(4)
            
            try:
                Preco=float(Preco)
            except ValueError:
                Preco= 0.00
                
#           if (temIPI):
#               Preco=Preco*1.1                
                
            if CodAplicacao=='0003':
                Preco=Preco*6.0
            elif CodAplicacao=='0004':
                Preco=Preco*20.0
                
##            Preco = Preco*(1-self.icmPisCofins) ##Retira os impostos      
                       
            sql= """
            exec dbo.AtualizaPrecoLista @IDLog = {IDLog}, @CodGrupoSub = '{CodGrupo}', @CodAplicacao = '{CodAplicacao}', @ComEmbalagem = {ComEmbalagem}, @Preco = {Preco:.2f}
            """.format(IDLog=IDLog, CodGrupo=CodGrupo, CodAplicacao=CodAplicacao, ComEmbalagem=ComEmbalagem, Preco=Preco)
            
            print(sql)
            
            cursor.execute(sql)
            
            conn.commit()
            
        for row in values:
            if len(row) >= 12:
                temIPI = (row[2]!='MP')
                if row[0]:
                    CodGrupo = row[0]
                    GravaPreco(IDLog, CodGrupo, '1030', 0, row[3], temIPI) # Kg
                    GravaPreco(IDLog, CodGrupo, '1031', 0, row[4], temIPI) # Litro
                    GravaPreco(IDLog, CodGrupo, '0',    1, row[5], temIPI) # Tambor com Embalagem
                    GravaPreco(IDLog, CodGrupo, '0',    0, row[6], temIPI) # Tambor sem Embalagem
                    GravaPreco(IDLog, CodGrupo, '6',    1, row[7], temIPI) # Bombona 50 Litros
                    GravaPreco(IDLog, CodGrupo, '2',    1, row[8], temIPI) # Lata 18 Litros
                    GravaPreco(IDLog, CodGrupo, '3',    1, row[9], temIPI) # Galão 5 Litros
                    GravaPreco(IDLog, CodGrupo, '4',    1, row[10],temIPI) # Lata 900 ml    
    
        print("Finalizado")            
                

def main():
    """Shows basic usage of the Sheets API.
    Prints values from a sample spreadsheet.
    """    
    
    leitor = LeitorLista()
    if len(sys.argv) <= 1:
        leitor.nomeLista = 'ND'
    else:
        leitor.nomeLista = sys.argv[1]
    
    leitor.FazerLeitura()

if __name__ == '__main__':
    main()