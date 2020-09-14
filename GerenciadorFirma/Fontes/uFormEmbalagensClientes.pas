unit uFormEmbalagensClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, cxCheckBox, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, uConSqlServer, Vcl.ComCtrls, Vcl.Menus, System.Generics.Collections,
  uSendMail, uFrmShowMemo;

type
  TFormEmbalagensClientes = class(TForm)
    cxGridEmbalagens: TcxGrid;
    cxGridViewEmbalagens: TcxGridDBTableView;
    cxGridEmbalagensLevel: TcxGridLevel;
    DsEmbalagensCli: TDataSource;
    QryEmbalagensCli: TFDQuery;
    QryEmbalagensCliCHAVENF: TStringField;
    QryEmbalagensCliCODCLIENTE: TStringField;
    QryEmbalagensCliRAZAOSOCIAL: TStringField;
    QryEmbalagensCliCIDADE: TStringField;
    QryEmbalagensCliENTREGAPARCIAL: TStringField;
    QryEmbalagensCliCODPRODUTO: TStringField;
    QryEmbalagensCliAPRESENTACAO: TStringField;
    QryEmbalagensCliDATACOMPROVANTE: TDateField;
    QryEmbalagensCliNUMERO: TStringField;
    QryEmbalagensCliSERIE: TStringField;
    QryEmbalagensCliQUANTATENDIDA: TBCDField;
    QryEmbalagensCliTOTPAGO: TFMTBCDField;
    QryEmbalagensCliSTATUS: TIntegerField;
    QryEmbalagensCliCHAVENFPRO: TStringField;

    cxGridViewEmbalagensCHAVENF: TcxGridDBColumn;
    cxGridViewEmbalagensCODCLIENTE: TcxGridDBColumn;
    cxGridViewEmbalagensRAZAOSOCIAL: TcxGridDBColumn;
    cxGridViewEmbalagensDATACOMPROVANTE: TcxGridDBColumn;
    cxGridViewEmbalagensNUMERO: TcxGridDBColumn;
    cxGridViewEmbalagensSERIE: TcxGridDBColumn;
    cxGridViewEmbalagensCIDADE: TcxGridDBColumn;
    cxGridViewEmbalagensTOTPAGO: TcxGridDBColumn;
    cxGridViewEmbalagensENTREGAPARCIAL: TcxGridDBColumn;
    cxGridViewEmbalagensCODPRODUTO: TcxGridDBColumn;
    cxGridViewEmbalagensAPRESENTACAO: TcxGridDBColumn;
    cxGridViewEmbalagensQUANTATENDIDA: TcxGridDBColumn;
    cxGridViewEmbalagensSTATUS: TcxGridDBColumn;
    cxGridViewEmbalagensCHAVENFPRO: TcxGridDBColumn;

    PopupMenu: TPopupMenu;
    CheckBoxMostrarIgnorados: TCheckBox;
    DataIniPicker: TDateTimePicker;
    Label1: TLabel;
    BtnAtualizar: TButton;
    Ignorarembalagem1: TMenuItem;

    cxStyleRepository1: TcxStyleRepository;
    cxStyleVermelho: TcxStyle;
    cxStyleAmarelo: TcxStyle;
    DeixardeIgnorarEmbalagem1: TMenuItem;
    QryEmbalagensCliDataVencimento: TDateField;
    cxGridViewEmbalagensDataVencimento: TcxGridDBColumn;
    QryEmbalagensCliDESCSTATUS: TStringField;
    cxGridViewEmbalagensDESCSTATUS: TcxGridDBColumn;
    BtnEnviarEmail: TButton;
    QryEmbalagensCliVALUNIDADE: TFMTBCDField;
    QryEmbalagensCliQuantDevolvida: TFMTBCDField;
    QryEmbalagensCliVALTOTAL: TBCDField;
    cxGridViewEmbalagensVALTOTAL: TcxGridDBColumn;
    cxGridViewEmbalagensVALUNIDADE: TcxGridDBColumn;
    cxGridViewEmbalagensQuantDevolvida: TcxGridDBColumn;
    PanelTop: TPanel;
    EditEmails: TEdit;
    Label2: TLabel;
    BtnContatos: TButton;
    QryEmbalagensCliQuantPendente: TFMTBCDField;
    cxGridViewEmbalagensQuantPendente: TcxGridDBColumn;
    DsEmail: TDataSource;
    QryEmail: TFDQuery;
    QryEmailIdentificador: TStringField;
    QryEmailUsuario: TStringField;
    QryEmailPassword: TStringField;
    QryEmailSMTPServer: TStringField;
    QryEmailPort: TIntegerField;
    QryEmailrequireAuth: TBooleanField;
    DsTextoEmail: TDataSource;
    QryTextoEmail: TFDQuery;
    QryTextoEmailIdentificador: TStringField;
    QryTextoEmailTitulo: TStringField;
    QryTextoEmailIntroducao: TMemoField;
    QryTextoEmailPoliticaDevolucao: TMemoField;
    QryTextoEmailAssinatura: TMemoField;
    QryImagemEmail: TFDQuery;
    QryImagemEmailidentificador: TStringField;
    QryImagemEmailIdImagem: TStringField;
    QryImagemEmailImagem: TBlobField;
    QryImagemEmailext: TStringField;
    DsImagemEmail: TDataSource;
    procedure Ignorarembalagem1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnAtualizarClick(Sender: TObject);
    procedure cxGridViewClientesStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure PopupMenuPopup(Sender: TObject);
    procedure DeixardeIgnorarEmbalagem1Click(Sender: TObject);
    procedure CheckBoxMostrarIgnoradosClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnEnviarEmailClick(Sender: TObject);
    procedure BtnContatosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FCodCliente: string;
    FSqlQryEmbalagensCli: String;
    FListaEmbalagensRecentes: TList<String>;
    FMailSender: TMailSender;
    FormShowMemo: TFormShowMemo;
    function EmbalagemRecenteENaoEnviada: Boolean;
    procedure MarcarEmbalagensComoEnviadas;
    procedure EviarEmailCliente;
    procedure AtualizaEmails;
  public
    procedure EnviaEmail;
    procedure CarregaEmbalagensCliente(ACodCliente: String);
    class procedure AbreEmbalagensCliente(ACodCliente: String);
    class procedure IgnoraEmbalagem(AChaveNFPRo: String); static;
  end;

var
  FormEmbalagensClientes: TFormEmbalagensClientes;

implementation

uses
  IdMessageBuilder, IdAttachmentMemory, uFormSelecionaEmailCliente;

{$R *.dfm}

class procedure TFormEmbalagensClientes.AbreEmbalagensCliente(
  ACodCliente: String);
var
  FFrm: TFormEmbalagensClientes;
begin
  FFrm:= TFormEmbalagensClientes.Create(nil);
  try
    FFrm.CarregaEmbalagensCliente(ACodCliente);
    FFrm.ShowModal;
  finally
    FFrm.Free;
  end;
end;

procedure TFormEmbalagensClientes.BtnAtualizarClick(Sender: TObject);
begin
  CarregaEmbalagensCliente(FCodCliente);
end;

procedure TFormEmbalagensClientes.AtualizaEmails;
  function getSql(ACodCliente, EmailEmbalagem: String): String;
  begin
    Result:= 'IF EXISTS(SELECT * FROM CLIENTEEMBALAGEM WHERE CODCLIENTE = '''+ACodCliente+''') '
            +Format('  UPDATE ClienteEmbalagem set EmailEmbalagem = ''%s'' where CodCliente = ''%s'' ',[EmailEmbalagem, ACodCliente])
            +' ELSE '
            +Format('INSERT INTO ClienteEmbalagem (CodCliente, EmailEmbalagem) values (''%s'', ''%s'') ', [ACodCliente, EmailEmbalagem]);
  end;
begin
  ConSqlServer.ExecutaComando(getSql(QryEmbalagensCliCodCliente.AsString, EditEmails.Text));
end;

procedure TFormEmbalagensClientes.BtnContatosClick(Sender: TObject);
begin
  EditEmails.Text:= TFormSelecionaEmailCliente.SelecionaEmailContatos(QryEmbalagensCliCodCliente.AsString, EditEmails.Text);
  AtualizaEmails;
end;

procedure TFormEmbalagensClientes.BtnEnviarEmailClick(Sender: TObject);
begin
  if Trim(EditEmails.Text) = '' then
  begin
    ShowMessage('É preciso indicar um email para enviar!');
    EditEmails.SetFocus;
    Exit;
  end;
  EnviaEmail;
end;


procedure TFormEmbalagensClientes.CarregaEmbalagensCliente(ACodCliente: String);
var
  FSql: String;
begin
  FCodCliente:= ACodCliente;

  QryEmbalagensCli.Close;

  FSql:= FSqlQryEmbalagensCli;
  if CheckBoxMostrarIgnorados.Checked = False then
    FSql:= FSql.Replace('/*Ignorados*/', ' AND IsNull(STATUS,0) < 2');

  QryEmbalagensCli.SQL.Text:= FSql;
  QryEmbalagensCli.ParamByName('CodCliente').AsString:= ACodCliente;
  QryEmbalagensCli.ParamByName('DataIni').AsDate:= DataIniPicker.Date;
  QryEmbalagensCli.Open;
  Self.Caption:= 'Embalagens pendentes do cliente '+QryEmbalagensCliRAZAOSOCIAL.AsString;

  EditEmails.Text:= ConSqlServer.RetornaValor(Format('SELECT EmailEmbalagem from ClienteEmbalagem where CodCliente = ''%s'' ',[ACodCliente]), '');
end;

procedure TFormEmbalagensClientes.CheckBoxMostrarIgnoradosClick(
  Sender: TObject);
begin
  CarregaEmbalagensCliente(FCodCliente);
end;

procedure TFormEmbalagensClientes.cxGridViewClientesStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if Sender.DataController.Values[ARecord.RecordIndex, cxGridViewEmbalagensSTATUS.Index] = 2 then
    AStyle := cxStyleAmarelo;
end;

procedure TFormEmbalagensClientes.DeixardeIgnorarEmbalagem1Click(
  Sender: TObject);
const
  cSqlDelete = 'DELETE FROM MCLIPROSTATUSRECB WHERE CHAVENFPRO= ''%s'' ';
begin
  ConSqlServer.ExecutaComando(Format(cSqlDelete, [QryEmbalagensCliChaveNFPRo.AsString]));
  QryEmbalagensCli.Refresh;
end;

// Considera como embalagem pendente notas de embalagem tiradas a no máximo um dia útil e que ainda não tiveram o email enviado
function TFormEmbalagensClientes.EmbalagemRecenteENaoEnviada: Boolean;
var
  FDecDias: Integer;
begin
  if QryEmbalagensCliSTATUS.AsInteger > 0 then // Status = 0 quer dizer que email da embalagem ainda não foi enviado
   Exit(False);

  if DayOfWeek(Now) = 2 then // Se for segunda considera as notas de sexta
    FDecDias:= 3
  else
    FDecDias:= 1;

  if QryEmbalagensCliDATACOMPROVANTE.AsDateTime >= Trunc(Now-FDecDias) then // Se nota foi tirada ontem ou hoje
    Result:= True
  else
    Result:= False; // Nota foi tirada a mais de um dia útil, considera como embalagem pendente
end;

procedure TFormEmbalagensClientes.EviarEmailCliente;
var
  FIdMessageBuilder: TIdMessageBuilderHtml;
  FHtml: String;

  function GetSituacao: string;
  begin
    if FListaEmbalagensRecentes.Contains(QryEmbalagensCliCHAVENFPRO.AsString) then   
      Result:= 'Enviado na última compra'
    else if QryEmbalagensCliDataVencimento.AsDateTime >= Trunc(Now) then
      Result:= 'Pendente'
    else
      Result:= 'Vencido';
  end;

  function AddTH(Text: String): String;
  begin
    Result:= '<th align="center" style="border: 1px solid; padding-left: 2px; padding-right: 2px; font-weight: bold;">'+Text+'</th>';
  end;

  function AddTD(Text: String): String;
  begin
    Result:= '<td align="center" style="border: 1px solid; padding-left: 10px; padding-right: 10px;">'+Text+'</td>';
  end;

  function GetHtml: String;
  begin
    Result:= '<HTML>'+QryTextoEmailIntroducao.AsString+'<br><br> '
            +'<table style="border:1px solid; border-collapse: collapse"><tr>'
            +AddTH('Data Emissão')
            +AddTH('NFe')
            +AddTH('Embalagem')
            +AddTH('Qtd. Pendente')
            +AddTH('Qtd. Devolvida')
            +AddTH('Data Vencimento')
            +AddTH('Situação')
            +'</tr> ';

    QryEmbalagensCli.First;
    while not QryEmbalagensCli.Eof do
    begin
      if QryEmbalagensCliQuantPendente.AsInteger > 0 then
        Result:= Result+'<tr> '
             +AddTD(DateToStr(QryEmbalagensCliDATACOMPROVANTE.AsDateTime))
             +AddTD(QryEmbalagensCliNumero.AsString+'-'+QryEmbalagensCliSerie.AsString)
             +AddTD(QryEmbalagensCliApresentacao.AsString)
             +AddTD(QryEmbalagensCliQuantPendente.AsString)
             +AddTD(IntToStr(QryEmbalagensCliQuantDevolvida.AsInteger))
             +AddTD(DateToStr(QryEmbalagensCliDataVencimento.AsDateTime))
             +AddTD(GetSituacao)+'</tr>';

      QryEmbalagensCli.Next;
    end;
    Result:= Result+'</table>'+
    '<br>'+QryTextoEmailPoliticaDevolucao.AsString+
    '<br><br>'+QryTextoEmailAssinatura.AsString+
    '</HTML>';
  end;

  function PrepareMessageBuilder(AHtml: String): TIdMessageBuilderHtml;
  var
    FAttachment: TIdMessageBuilderAttachment;
    FStream: TMemoryStream;
    FContentType: String;
  begin
    Result:= FMailSender.NewMessageBuilder(AHtml);
    try
      QryImagemEmail.First;
      while not QryImagemEmail.Eof do
      begin
        if QryImagemEmailext.AsString.ToUpper.Contains('PNG') then
          FContentType:= 'image/png'
        else
          FContentType := 'image/jpeg';

        FStream:= TMemoryStream.Create;
        QryImagemEmailImagem.SaveToStream(FStream);
        FStream.Position:= 0;
        FAttachment := Result.HtmlFiles.Add(FStream, FContentType, QryImagemEmailIdImagem.AsString);
//        FAttachment.FileName:= 'C:\Users\Marcelo\Desktop\Firma\Logo.png';

        QryImagemEmail.Next;
      end;
    except
      Result.Free;
      raise
    end;
  end;

var
  I: Integer;
begin
  FormShowMemo.Show;
  try
    FormShowMemo.SetText('Enviando email para o cliente '+QryEmbalagensCliRAZAOSOCIAL.AsString);

//    FIdMessage := FMailSender.PrepareMessage(QryTextoEmailTitulo.AsString, GetHtml, EditEmails.Text, QryEmailUsuario.AsString);
    FHtml:= GetHtml;
    FIdMessageBuilder:= PrepareMessageBuilder(FHtml);
    try
      FMailSender.SendEmailFromMessageBuilder(QryTextoEmailTitulo.AsString, FHtml, EditEmails.Text, QryEmailUsuario.AsString, '', FIdMessageBuilder, False);
    finally
      for I:= 0 to FIdMessageBuilder.HtmlFiles.Count-1 do
        if FIdMessageBuilder.HtmlFiles[I].Data <> nil then
         FIdMessageBuilder.HtmlFiles[I].Data.Free;

      FIdMessageBuilder.Free;
    end;


//    FMailSender.SendMessage(FIdMessage);
  finally
    FormShowMemo.Hide;
  end;
end;

procedure TFormEmbalagensClientes.EnviaEmail;
begin
  if QryEmbalagensCli.RecordCount = 0 then
    Exit;

  FListaEmbalagensRecentes.Clear;
  QryEmbalagensCli.First;
  while not QryEmbalagensCli.Eof do
  begin
    if EmbalagemRecenteENaoEnviada then
      FListaEmbalagensRecentes.Add(QryEmbalagensCliCHAVENFPRO.AsString)
    else
      Break;

    QryEmbalagensCli.Next;
  end;

  EviarEmailCliente;
  // IMPLEMENTAR: Faz envio de email;

  MarcarEmbalagensComoEnviadas;
  QryEmbalagensCli.Refresh;
  //raise exception.Create('Error Message');
end;

procedure TFormEmbalagensClientes.MarcarEmbalagensComoEnviadas;
const
  cSqlStatus = 'exec AlteraMCLIPROSTATUSRECB ''%s'', %d, ''%s'' ';
begin
  QryEmbalagensCli.First;
  while not QryEmbalagensCli.Eof do
  begin
    ConSqlServer.ExecutaComando(Format(cSqlStatus, [QryEmbalagensCliChaveNFPro.AsString, 1, 'Email enviado']));
    QryEmbalagensCli.Next;
  end;
end;

procedure TFormEmbalagensClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  AtualizaEmails;
end;

procedure TFormEmbalagensClientes.FormCreate(Sender: TObject);
begin
  FormShowMemo:= TFormShowMemo.Create(Self);

  QryEmail.Open;
  QryTextoEmail.Open;
  QryImagemEmail.Open;
  FMailSender:= TMailSender.Create(Self, QryEmailSMTPServer.AsString, QryEmailPort.AsInteger, QryEmailUsuario.AsString,
                  QryEmailPassword.AsString, QryEmailrequireAuth.AsBoolean, QryEmailUsuario.AsString);
  FListaEmbalagensRecentes:= TList<String>.Create;
  FSqlQryEmbalagensCli:= QryEmbalagensCli.SQL.Text;
end;

procedure TFormEmbalagensClientes.FormDestroy(Sender: TObject);
begin
  FListaEmbalagensRecentes.Free;
end;

class procedure TFormEmbalagensClientes.IgnoraEmbalagem(AChaveNFPRo: String);
const
  cSqlInsert = 'exec AlteraMCLIPROSTATUSRECB ''%s'', %d, ''%s'' ';
var
  fMensagem: String;
begin
  if AChaveNFPRo = '' then
    Exit;

  if MessageDlg('Você tem certeza que deseja ignorar esta nota de embalagem?'+
                sLineBreak+'Após a nota de embalagem ser ignorada ela não irá mais aparecer para envio de email para o cliente.', mtConfirmation,
                [mbYes, mbNo], 0
                ) = mrNo then
    Exit;

  FMensagem:= InputBox('Digite a justificativa', 'Mínimo de 5 caracteres', '');
  if Length(FMensagem) < 5 then
  begin
    ShowMessage('Justificativa deve ter um minímo de 5 caracteres.');
    Exit;
  end;

  ConSqlServer.ExecutaComando(Format(cSqlInsert, [AChaveNFPRo, 2, FMensagem]));
end;

procedure TFormEmbalagensClientes.Ignorarembalagem1Click(Sender: TObject);
begin
  TFormEmbalagensClientes.IgnoraEmbalagem(QryEmbalagensCliCHAVENFPRO.AsString);
  QryEmbalagensCli.Refresh;
end;

procedure TFormEmbalagensClientes.PopupMenuPopup(Sender: TObject);
begin
  if QryEmbalagensCliCHAVENFPRO.AsString = '' then
    Exit;

  Ignorarembalagem1.Visible:=  QryEmbalagensCliSTATUS.AsInteger <> 2;
  DeixardeIgnorarEmbalagem1.Visible:= QryEmbalagensCliSTATUS.AsInteger = 2;
end;

end.
