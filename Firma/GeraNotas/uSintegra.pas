unit uSintegra;

interface

uses
  Db, DBTables, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  Gauges, StdCtrls, ExtCtrls, Spin, CheckLst, DBCtrls, SysUtils;

type
  TfSintegra = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    Label1: TLabel;
    GGeral: TGauge;
    GParcial: TGauge;
    Label3: TLabel;
    EditConvenio: TEdit;
    RGCampo11: TRadioGroup;
    RGCampo12: TRadioGroup;
    GroupBox1: TGroupBox;
    CLMes: TCheckListBox;
    GroupBox2: TGroupBox;
    SpinAno: TSpinEdit;
    Button3: TButton;
    Button4: TButton;
    SQL_Tipo60M: TQuery;
    SQL_Tipo50: TQuery;
    CheckTipo50: TCheckBox;
    CheckTipo60: TCheckBox;
    RGEmitente: TRadioGroup;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function GeraRegTipo50(Tbl, Tbl1: TDBDataSet): integer;
  procedure GeraRegTipo60M(Tbl: TDBDataSet);
  procedure GeraRegTipo60A(Tbl, Tbl1: TDBDataSet);
  function Alinha(Texto, Posicao, Preenchimento : string; Tamanho : integer) : string;

var
  fSintegra: TfSintegra;
  vArq : TextFile;

implementation

{$R *.DFM}

uses
  uDtm_Empresa, uCad_Empresa, uDtm_Par, uCad_DadosSintegra, uDtm_Sintegra, uDtm_Ent, uFuncional;

procedure TfSintegra.Button1Click(Sender: TObject);
var
  DataIni, DataFim: TDateTime;
  x, Cont50, Cont60: integer;
  vLny : string;
  Ano, Mes, Dia : Word;
begin
  GGeral.Progress := 0;
  GGeral.MaxValue := CLMes.Items.Count;
  for x := 0 to CLMes.Items.Count - 1 do
    begin
      if CLMes.Checked[x] = true then
        begin
          DataIni := EncodeDate(SpinAno.Value,(x + 1),1);
          if x < 11 then
            begin
              DataFim := EncodeDate(SpinAno.Value,(x + 2),1);
            end
          else
            begin
              DataFim := EncodeDate((SpinAno.Value + 1),1,1);
            end;
          DataFim := (DataFim - 1);

          DecodeDate(DataIni,Ano,Mes,Dia);

         DecodeDate(DataIni, Ano, Mes, Dia); //Ve se já existe um arquivo criado naquele dia: Se tiver o deleta
         if FileExists(ExtractFilePath(Application.ExeName)+'Arquivos\'+IntToStr(Ano)+IntToStr(Mes)+IntToStr(Dia)+'.txt') then
           begin
             DeleteFile(ExtractFilePath(Application.ExeName)+'Arquivos\'+IntToStr(Ano)+IntToStr(Mes)+IntToStr(Dia)+'.txt');
           end;
         AssignFile(vArq,ExtractFilePath(Application.ExeName)+'Arquivos\'+IntToStr(Ano)+IntToStr(Mes)+IntToStr(Dia)+'.txt');
         ReWrite(vArq);

          with Dtm_Empresa do
            begin
//Registro tipo 10 - Mestre do estabelecimento
              VLny := '10';//Campo 1 - "10" Fixo
              vLny := vLny + Alinha(Tbl_EmpresaCGC.AsString,'D','0',14);//Campo 2 - CGC/IMF do estabelecimento informante
              vLny := vLny + Alinha(Tbl_EmpresaIE.AsString,'E',' ',14);//Campo 3 - IE
              vLny := vLny + Alinha(Tbl_EmpresaNome.AsString,'E',' ',35);//Campo 4 - Razão social
              vLny := vLny + Alinha(Tbl_EmpresaMunicipio.asString,'E',' ',30);//Campo 5 - Municipio
              vLny := vLny + Alinha(UpperCase(Tbl_EmpresaUF.AsString),'E',' ',2);//Campo 6 - UF
              vLny := vLny + Alinha(Tbl_EmpresaFax.AsString,'D','0',10);//Campo 7 - Número do fax
              DecodeDate(DataIni,Ano,Mes,Dia);
//Campo 8 - Data do inicio do periodo referente as informações prestadas
              vLny := vLny + Alinha(FormatFloat('0000',Ano)+FormatFloat('00',Mes)+FormatFloat('00',Dia),'D','0',8);
              DecodeDate(DataFim,Ano,Mes,Dia);
//Campo 9 - Data do fim do periodo referente as informações prestadas
              vLny := vLny + Alinha(FormatFloat('0000',Ano)+FormatFloat('00',Mes)+FormatFloat('00',Dia),'D','0',8);
              vLny := vLny + Alinha(EditConvenio.text,'E',' ',1);//Campo 10 Código de identificação do convenio...
              vLny := vLny + Alinha(IntToStr(RGCampo11.ItemIndex + 1),'E',' ',1);//Campo 11 Identificação das informações
              vLny := vLny + Alinha(IntToStr(RGCampo12.ItemIndex + 1),'E',' ',1);//Campo 12 Identificação do arquivo

              WriteLN(vArq,vLny);

//Registro tipo 11
              vLny := '11';//Campo 1 - Fixo "11"
              vLny := vLny + Alinha(Tbl_EmpresaEndereco.AsString,'E',' ',34);//Campo 2
              vLny := vLny + Alinha(Tbl_EmpresaNumero.AsString,'D','0',5);//Campo 3
              vLny := vLny + Alinha(Tbl_EmpresaComplemento.AsString,'E',' ',22);//Campo 4
              vLny := vLny + Alinha(Tbl_EmpresaBairro.asString,'E',' ',15);//Campo 5
              vLny := vLny + Alinha(Tbl_EmpresaCEP.AsString,'D','0',8);//Campo 6
              vLny := vLny + Alinha(Tbl_EmpresaContato.AsString,'E',' ',28);//Campo 7 - Pessoa responsavel para contatos
              vLny := vLny + Alinha(Tbl_EmpresaTelefone.AsString,'D','0',12);//Campo 8 - Número dos telefones para contatos
              WriteLN(vArq,vLny);
            end;

          Cont50:= 0;

          if CheckTipo50.Checked then
            begin
              Sql_Tipo50.Close;
              Sql_Tipo50.Sql.Clear;
              Sql_Tipo50.Sql.Add('Select Entrada, Data');
              Sql_Tipo50.Sql.Add('from TBEntrada');
              Sql_Tipo50.Sql.Add('where Data Between :DataIni and :DataFim');
              Sql_Tipo50.Sql.Add('Order By Data');

              Sql_Tipo50.ParamByName('DataIni').AsDateTime:= DataIni;
              Sql_Tipo50.ParamByName('DataFim').AsDateTime:= DataFim;
              Sql_Tipo50.Open;

              GParcial.Progress:= 0;
              GParcial.MaxValue:= Sql_Tipo50.RecordCount;
              Sql_Tipo50.First;
              while not Sql_Tipo50.EOF do
                begin
                  with Dtm_Ent do
                    begin
                      Tbl_Ent.FindKey([Sql_Tipo50.FieldByName('Entrada').AsInteger]);
                      Cont50:= Cont50 + (GeraRegTipo50(Tbl_Ent, Tbl_AliqEnt));
                    end;
                  Sql_Tipo50.Next;
                  GParcial.Progress:= GParcial.Progress + 1;
                end;
            end;
          Cont60:= 0;

          if CheckTipo60.Checked then
            begin
              Sql_Tipo60M.Close;     //Prepara a tabela do registro tipo 60 Master
              SQL_Tipo60M.Sql.Clear; //Faz o filtro de acordo com o perido informado
              SQL_Tipo60M.SQL.Add('Select Tipo60M, DataEmissao, Maquina');
              SQL_Tipo60M.SQL.Add('from TBTIpo60M');
              Sql_Tipo60M.SQL.Add('where DataEmissao between :DataIni and :DataFim');
//              Sql_Tipo60M.SQL.Add('Maquina = :Maquina');
              Sql_Tipo60M.Sql.Add('Order By DataEmissao');
              Sql_Tipo60M.ParamByName('DataIni').AsDateTime:= DataIni;
              Sql_Tipo60M.ParamByName('DataFim').AsDateTime:= DataFim;
//              Sql_Tipo60M.ParamByName('Maquina').AsInteger:= Dtm_Sintegra.Tbl_Tipo60MMaquina.AsInteger;
              Sql_Tipo60M.Open;

              GParcial.Progress:= 0;
              GParcial.MaxValue:= SQL_Tipo60M.RecordCount;
              Sql_Tipo60M.First;
              with DTM_Sintegra do
              while not Sql_Tipo60M.EOF do
                begin
                  Tbl_Tipo60M.FindKey([Sql_Tipo60M.FieldByName('Tipo60M').AsInteger]);
                  GeraRegTipo60M(Tbl_Tipo60M);  //Procedure q gera o registro
                  Dtm_Sintegra.Tbl_Tipo60A.First;
                  while not Dtm_Sintegra.Tbl_Tipo60A.EOF do
                    begin
                      GeraRegTipo60A(Tbl_Tipo60A, Tbl_Tipo60M);
                      Dtm_Sintegra.Tbl_Tipo60A.Next;
                      Cont60:= Cont60 + 1;
                    end;
                  Cont60:= Cont60 + 1;  //Aumenta um na contagem de regitros no arquivo
                  Sql_Tipo60M.Next;
                  GParcial.Progress:= GParcial.Progress + 1;
                end;
            end;

         with Dtm_Empresa do
           begin
             vLny := '90';
             vLny := vLny + Alinha(Tbl_EmpresaCGC.AsString,'D','0',14);
             vLny := vLny + Alinha(Tbl_EmpresaIE.AsString,'E',' ',14);
             if Cont50 > 0 then
               begin
                 vLny := vLny + '50';
                 vLny := vLny + Alinha(IntToStr(Cont50),'D','0',8);
               end;
             if Cont60 > 0 then
               begin
                 vLny := vLny + '60';
                 vLny := vLny + Alinha(IntToStr(Cont60),'D','0',8);
               end;

              vLny := vLny + '99';
              vLny := vLny + Alinha(IntToStr(Cont60 + Cont50 + 3),'D','0',8);
              vLny := vLny + Alinha('1','D',' ',(126 - Length(vLny)));
              WriteLN(vArq,vLny);
            end;
          CloseFile( vArq);
        end;
//Aumenta 1 no Gauge
      GGeral.Progress := GGeral.Progress + 1;
    end;
//Zera o Gauge
  GGeral.Progress := 0;
  GParcial.Progress := 0;
  ShowMessage('Operação Concluída!!');
end;

function Alinha(Texto, Posicao, Preenchimento : string; Tamanho : integer) : string;
var
  x : integer;
  molda : string;
begin
  result := texto;
  if Posicao = 'D' then
    begin
      While Length(Result) < Tamanho do
        begin
          Result := Preenchimento + Result;
        end;
    end
  else if Posicao = 'E' then
    begin
      While Length(Result) < Tamanho do
        begin
          Result := Result + Preenchimento;
        end;
    end
  else
    begin
      ShowMessage('A posição definida para o texto não está prevista!');
    end;
  if Length(Result) > Tamanho then
    begin
      Molda := '';
      For x := 1 to Tamanho do
        begin
          Molda := Molda + Result[x];
        end;
      Result := Molda;
    end;
end;


procedure TfSintegra.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfSintegra.Button3Click(Sender: TObject);
begin
  fCad_Empresa:=TfCad_Empresa.Create(Self);
  fCad_Empresa.ShowModal;
  fCad_Empresa.Free;
end;

function GeraRegTipo50(Tbl, Tbl1: TDBDataSet): integer;
var
  Resultado: Integer;
  vLinha: String;
  Aliquota, ValorTotal, BaseCalculo, ValorICMS, Isenta, Outras: String;
  Ano, Mes, Dia: Word;
begin
  DecodeDate(Tbl.FieldByName('Data').AsDateTime, Ano, Mes, Dia);

  Tbl1.First;
  Resultado:= 0;
  while not Tbl1.EOF do
    begin
      if Tbl1.FieldByName('Aliquota').AsString <> '' then
      Aliquota:= Copy(FormatFloat('00.00', Tbl1.FieldByName('Aliquota').AsFloat), 0, 2) + Copy(FormatFloat('00.00', Tbl1.FieldByName('Aliquota').AsFloat), 4, 2);

      Aliquota:= StringReplace(Aliquota, ',', '', [rfReplaceAll]);

      ValorTotal:= StringReplace(Tbl1.FieldByName('ValorTotal').AsString, ',', '', [rfReplaceAll]);
      BaseCalculo := StringReplace(Tbl1.FieldByName('BaseCalculo').AsString, ',', '', [rfReplaceAll]);
      ValorICMS:= StringReplace(Tbl1.FieldByName('ValorICMS').AsString, ',', '', [rfReplaceAll]);
      Isenta:= StringReplace(Tbl1.FieldByName('Isenta').AsString, ',', '', [rfReplaceAll]);
      Outras:= StringReplace(Tbl1.FieldByName('Outras').AsString, ',', '', [rfReplaceAll]);

      vLinha:= '50'; //Campo 1 "50" fixo
      vLinha:= vLinha + Alinha(Tbl.FieldByName('CGC').AsString, 'D', '0', 14);
      if Tbl.FieldByName('IE').AsString <> '' then
      vLinha:= vLinha + Alinha(Tbl.FieldByName('IE').AsString, 'E', ' ', 14)
      else
      vLinha:= vLinha + Alinha('ISENTO', 'E', ' ', 14);

      vLinha:= vLinha + Alinha(FormatFloat('0000', Ano) + FormatFloat('00', Mes) + FormatFloat('00', Dia), 'D', '0', 8);
      vLinha:= vLinha + Alinha(UpperCase(Tbl.FieldByName('UF').AsString), 'E', ' ', 2);
      vLinha:= vLinha + Alinha(Tbl.FieldByName('Modelo').AsString, 'D', '0', 2);
      vLinha:= vLinha + Alinha(Tbl.FieldByName('Serie').AsString, 'E', ' ', 3);
//     vLinha:= vLinha + Alinha(Tbl.FieldByName('SubSerie').AsString, 'E', ' ', 2);
      vLinha:= vLinha + Alinha(Tbl.FieldByName('Nota').AsString, 'D', '0', 6);
      vLinha:= vLinha + Alinha(Tbl.FieldByName('NumCFOP').AsString, 'D', '0', 4);
      if fSintegra.RGEmitente.ItemIndex = 0 then
      vLinha:= vLinha + Alinha('P', 'E', ' ', 1)
      else
      vLinha:= vLinha + Alinha('T', 'E', ' ', 1);

      vLinha:= vLinha + Alinha(ValorTotal, 'D', '0', 13);
      vLinha:= vLinha + Alinha(BaseCalculo, 'D', '0', 13);
      vLinha:= vLinha + Alinha(ValorICMS, 'D', '0', 13);
      vLinha:= vLinha + Alinha(Isenta, 'D', '0', 13);
      vLinha:= vLinha + Alinha(Outras, 'D', '0', 13);
      vLinha:= vLinha + Alinha(Aliquota, 'D', '0', 4);
      vLinha:= vLinha + Alinha(Tbl.FieldByName('Situacao').AsString, 'E', ' ', 1);
      Writeln(vArq, vLinha);
      Tbl1.Next;
      inc(Resultado);
    end;
  Result:= Resultado;
end;

procedure GeraRegTipo60M(Tbl: TDBDataSet);
var
  vLinha: String;
  Ano, Mes, Dia: Word;
  TotalGeralIni, TotalGeralFim: String;
begin
  TotalGeralIni:= StringReplace(Tbl.FieldByName('VendaBruta').AsString, ',', '', [rfReplaceAll]);
  TotalGeralFim:= StringReplace(Tbl.FieldByName('TotalGeral').AsString, ',', '', [rfReplaceAll]);

  vLinha:= '60'; //Campo 1
  vLinha:= vLinha + 'M'; //Campo 2
  DecodeDate(Tbl.FieldByName('DataEmissao').AsDateTime,Ano,Mes,Dia);
  vLinha := vLinha + Alinha(FormatFloat('0000',Ano)+FormatFloat('00',Mes)+FormatFloat('00',Dia),'D','0',8); //Campo 3
  vLinha:= vLinha + Alinha(Tbl.FieldByName('NumSerie').AsString, 'E', ' ', 20); //Campo 4   <---
  vLinha:= vLinha + Alinha(Tbl.FieldByName('NumMaquina').AsString, 'D', '0', 3); //Campo 5 Trocado????
  vLinha:= vLinha + Alinha(Tbl.FieldByName('ModDoc').AsString, 'E', ' ', 2); //Campo 6
  vLinha:= vLinha + Alinha(Tbl.FieldByName('NumContIni').AsString, 'D', '0', 6); //Campo 7
  vlinha:= vLinha + Alinha(Tbl.FieldByName('NumContFim').AsString, 'D', '0', 6); //Campo 8
  vLinha:= vlinha + Alinha(Tbl.FieldByName('NumContRedZ').AsString, 'D', '0', 6); //Campo 9
  vLinha:= vLinha + Alinha(Tbl.FieldByName('Reinicio').AsString, 'D', '0', 3); //Campo 10 ??????
  vLinha:= vLinha + Alinha(TotalGeralIni, 'D', '0', 16); //Campo 11 ?????
  vLinha:= vLinha + Alinha(TotalGeralFim, 'D', '0', 16); //Campo 12 ?????
  vLinha:= vlinha + Alinha('', 'E', ' ', 37); //Campo 13 ?????
  Writeln(vArq, vLinha);
//  CloseFile(vArq);
end;

procedure GeraRegTipo60A(Tbl, Tbl1: TDBDataSet);
var
  vLinha: String;
  Ano, Mes, Dia: Word;
  Aliquota, TotalParcial, Brancos: String;
begin
  try
    StrToFloat(Tbl.FieldByName('Aliquota').AsString);
  except
  on EConvertError do
    Aliquota:= Tbl.FieldByName('Aliquota').AsString;
  end;
  if Aliquota = '' then
  Aliquota:= Copy(FormatFloat('00.00', Tbl.FieldByName('Aliquota').AsFloat), 0, 2) + Copy(FormatFloat('00.00', Tbl.FieldByName('Aliquota').AsFloat), 4, 2);

  Aliquota:= StringReplace(Aliquota, ',', '', [rfReplaceAll]);

  TotalParcial:= StringReplace(Tbl.FieldByName('TotalParcial').AsString, ',', '', [rfReplaceAll]);

  Brancos:= '';

  vLinha:= '60'; //Campo 1 - Fixo 60
  vLinha:= vLinha + 'A'; //Campo 2 - Fixo "A"
  DecodeDate(Tbl1.FieldByName('DataEmissao').AsDateTime,Ano,Mes,Dia);
  vLinha := vLinha + Alinha(FormatFloat('0000',Ano)+FormatFloat('00',Mes)+FormatFloat('00',Dia),'D','0',8); //Campo 3
  vLinha:= vLinha + Alinha(Tbl1.FieldByName('NumSerie').AsString, 'E', ' ', 20); //Campo 4
  vLinha:= vLinha + Alinha(Aliquota, 'E', ' ', 4); //Campo 5
  vLinha:= vLinha + Alinha(TotalParcial, 'D', '0', 12); //Campo 6
  vLinha:= vlinha + Alinha(Brancos, 'E', ' ', 79); //Campo 7
  Writeln(vArq, vLinha);
end;

procedure TfSintegra.Button4Click(Sender: TObject);
begin
  fCad_DadosSintegra:= TfCad_DadosSintegra.Create(Self);
  fCad_DadosSintegra.ShowModal;
  fCad_DadosSintegra.Free;
end;

end.
