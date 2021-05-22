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
  uSendMail, uFrmShowMemo, Utils;


type
  TStatusNota = (snRecemEmitido, snPendente, snAVencer, snVencido);

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
    QryTextoEmailAssinatura: TMemoField;
    QryImagemEmail: TFDQuery;
    QryImagemEmailidentificador: TStringField;
    QryImagemEmailIdImagem: TStringField;
    QryImagemEmailImagem: TBlobField;
    QryImagemEmailext: TStringField;
    DsImagemEmail: TDataSource;
    QryEmbalagensCliValorPendente: TFMTBCDField;
    cxGridViewEmbalagensValorPendente: TcxGridDBColumn;
    QryTextoEmailCorpo: TMemoField;
    QryEmbalagensCliSEQUENCIADOPRODUTO: TIntegerField;
    QryEmbalagensCliENVIADOAVENCER: TBooleanField;
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
    FIdentificador: String;
    function EmbalagemRecenteENaoEnviada: Boolean;
    procedure MarcarEmbalagensComoEnviadas;
    procedure EviarEmailCliente(AEmailDestino: String; ACopyToSelf: Boolean = True);
    procedure AtualizaEmails;
    function ReplaceWildcards(AText: String): String;
    function GetStatusNota: TStatusNota; overload;
    function GetStatusNota(ADataVencimento: TDateTime): TStatusNota; overload;
    function StatusNotaAsString(AStatus: TStatusNota): string;
    function VerificarConsistenciaDevolucao: Boolean;
  public
    function EnviaEmail: Boolean;
    procedure EnviaEmailTeste(AEmailDestino: String);
    procedure CarregaEmbalagensCliente(ACodCliente: String; AIdentificador: String);
    class procedure AbreEmbalagensCliente(ACodCliente: String; AIdentificador: String);
  end;

var
  FormEmbalagensClientes: TFormEmbalagensClientes;

implementation

uses
  IdMessageBuilder, IdAttachmentMemory, uFormSelecionaEmailCliente, uFormAjustaInconsistencias, uFormEmbalagensAVencer;

{$R *.dfm}

class procedure TFormEmbalagensClientes.AbreEmbalagensCliente(
  ACodCliente: String; AIdentificador: String);
var
  FFrm: TFormEmbalagensClientes;
begin
  FFrm:= TFormEmbalagensClientes.Create(nil);
  try
    FFrm.CarregaEmbalagensCliente(ACodCliente, AIdentificador);
    FFrm.ShowModal;
  finally
    FFrm.Free;
  end;
end;

procedure TFormEmbalagensClientes.BtnAtualizarClick(Sender: TObject);
begin
  CarregaEmbalagensCliente(FCodCliente, FIdentificador);
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

function TFormEmbalagensClientes.VerificarConsistenciaDevolucao: Boolean;
begin
  Result:= False;
  QryEmbalagensCli.First;
  while not QryEmbalagensCli.Eof do
  begin
    TFormAjustaInconsistencias.VerificaEAjustaInconsistenciaEmbalagem(QryEmbalagensCliChaveNF.AsString);
    if TFormAjustaInconsistencias.NotaEmbalagemInconsistente(QryEmbalagensCliChaveNF.AsString) then
    begin
      ShowMessage(Format('Inconsistência ainda existe, email para o cliente %s não será enviado até as inconsistências serem resolvidas.',
                            [QryEmbalagensCliRazaoSocial.AsString]));
      Exit;
    end;

    QryEmbalagensCli.Next;
  end;
  QryEmbalagensCli.Refresh;
  Result:= True;
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

procedure TFormEmbalagensClientes.CarregaEmbalagensCliente(ACodCliente: String; AIdentificador: String);
var
  FSql: String;
begin
  FIdentificador:= AIdentificador;
  FCodCliente:= ACodCliente;

  QryEmbalagensCli.Close;

  FSql:= FSqlQryEmbalagensCli;
  if CheckBoxMostrarIgnorados.Checked = False then
    FSql:= FSql.Replace('/*Ignorados*/', ' AND IsNull(STATUS,0) < 2');

  QryEmbalagensCli.Close;
  QryEmbalagensCli.SQL.Text:= FSql;
  QryEmbalagensCli.ParamByName('CodCliente').AsString:= ACodCliente;
  QryEmbalagensCli.ParamByName('DataIni').AsDate:= DataIniPicker.Date;
  QryEmbalagensCli.Open;

  QryTextoEmail.Close;
  QryTextoEmail.ParamByName('Identificador').AsString:= AIdentificador;
  QryTextoEmail.Open;

  Self.Caption:= 'Embalagens pendentes do cliente '+QryEmbalagensCliRAZAOSOCIAL.AsString;

  EditEmails.Text:= ConSqlServer.RetornaValor(Format('SELECT EmailEmbalagem from ClienteEmbalagem where CodCliente = ''%s'' ',[ACodCliente]), '');
end;

procedure TFormEmbalagensClientes.CheckBoxMostrarIgnoradosClick(
  Sender: TObject);
begin
  CarregaEmbalagensCliente(FCodCliente, FIdentificador);
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
begin
  TFormEmbalagensAVencer.DeixarDeIgnorarEmbalagem(QryEmbalagensCliChaveNFPRo.AsString, QryEmbalagensCliSEQUENCIADOPRODUTO.AsInteger);
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

procedure TFormEmbalagensClientes.EviarEmailCliente(AEmailDestino: String; ACopyToSelf: Boolean = True);
var
  FIdMessageBuilder: TIdMessageBuilderHtml;
  FHtml: String;

  function GetHtml: String;
  begin
    Result:= '<HTML>'+ReplaceWildcards(QryTextoEmailIntroducao.AsString)+
    ReplaceWildcards(QryTextoEmailCorpo.AsString)+
    ReplaceWildcards(QryTextoEmailAssinatura.AsString)+
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
  FEmailDestino: String;
  FEmailCC: String;
begin
  FormShowMemo.Show;
  try
    FormShowMemo.SetText('Enviando email para o cliente '+QryEmbalagensCliRAZAOSOCIAL.AsString);

//    FIdMessage := FMailSender.PrepareMessage(QryTextoEmailTitulo.AsString, GetHtml, EditEmails.Text, QryEmailUsuario.AsString);
    FHtml:= GetHtml;
    FIdMessageBuilder:= PrepareMessageBuilder(FHtml);
    try
      if ACopyToSelf then
        FEmailCC:= QryEmailUsuario.AsString
      else
        FEmailCC:= '';

      FMailSender.SendEmailFromMessageBuilder(QryTextoEmailTitulo.AsString, FHtml, AEmailDestino, FEmailCC, '', FIdMessageBuilder, False);
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

function TFormEmbalagensClientes.EnviaEmail: Boolean;
begin
  Result:= False;
  if QryEmbalagensCli.RecordCount = 0 then
    Exit;

  if VerificarConsistenciaDevolucao = False then
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

  EviarEmailCliente(EditEmails.Text, True);

  MarcarEmbalagensComoEnviadas;
  QryEmbalagensCli.Refresh;
  Result:= True;
  //raise exception.Create('Error Message');
end;

procedure TFormEmbalagensClientes.EnviaEmailTeste(AEmailDestino: String);
begin
  EviarEmailCliente(AEmailDestino, False);
end;

procedure TFormEmbalagensClientes.MarcarEmbalagensComoEnviadas;
begin
  QryEmbalagensCli.First;
  while not QryEmbalagensCli.Eof do
  begin
    TFormEmbalagensAVencer.AlteraStatusEmbalagem(QryEmbalagensCliChaveNFPro.AsString, QryEmbalagensCliSEQUENCIADOPRODUTO.AsInteger, 1, 'Email enviado.');
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

procedure TFormEmbalagensClientes.Ignorarembalagem1Click(Sender: TObject);
begin
  TFormEmbalagensAVencer.IgnoraEmbalagem(QryEmbalagensCliCHAVENFPRO.AsString, QryEmbalagensCliSEQUENCIADOPRODUTO.AsInteger);
  QryEmbalagensCli.Refresh;
end;

procedure TFormEmbalagensClientes.PopupMenuPopup(Sender: TObject);
begin
  if QryEmbalagensCliCHAVENFPRO.AsString = '' then
    Exit;

  Ignorarembalagem1.Visible:=  QryEmbalagensCliSTATUS.AsInteger <> 2;
  DeixardeIgnorarEmbalagem1.Visible:= QryEmbalagensCliSTATUS.AsInteger = 2;
end;

function TFormEmbalagensClientes.GetStatusNota(ADataVencimento: TDateTime): TStatusNota;
begin
  if ADataVencimento >= Trunc(Now)+14 then
    Result:= snPendente
  else if ADataVencimento >= Trunc(Now) then
    Result:= snAVencer
  else
    Result:= snVencido;
end;

function TFormEmbalagensClientes.GetStatusNota: TStatusNota;
begin
  if FListaEmbalagensRecentes.Contains(QryEmbalagensCliCHAVENFPRO.AsString) then
    Result:= snRecemEmitido
  else Result:= GetStatusNota(QryEmbalagensCliDataVencimento.AsDateTime);
end;

function TFormEmbalagensClientes.StatusNotaAsString(AStatus: TStatusNota): string;
begin
  case AStatus of
    snRecemEmitido: Result:= 'Enviado na última compra';
    snPendente: Result:= 'Pendente';
    snAVencer: Result:= 'A Vencer';
    snVencido: Result:= 'Vencido';
    else Result:= '';
  end;
end;

function TFormEmbalagensClientes.ReplaceWildcards(AText: String): String;
  function AddTH(Text: String): String;
  begin
    Result:= '<th style="text-align:center;font-family:arial;font-size:12px;border:1px solid;padding-left:2px;padding-right:2px;font-weight: bold;">'+Text+'</th>';
  end;

  function AddTD(Text: String; AAlignment: TAlignment): String;
  var
    FAlignment: String; FPaddingLeft: String;
  begin
    case AAlignment of
      taLeftJustify: FAlignment:= 'left';
      taRightJustify: FAlignment:= 'right';
      else
        FAlignment:= 'center';
    end;
    FAlignment:= 'text-align:'+FAlignment;
    Result:= '<td style="font-family:arial;font-size:12px;border:1px solid;padding-left:10px;padding-right:10px;'+FAlignment+'">'+Text+'</td>';
  end;

  function GetTabelaEmbalagensPendentes: String;
  begin
    Result:= '<table style="border:1px solid; border-collapse: collapse"><tr>'
            +AddTH('Data Emissão')
            +AddTH('Data Vencimento')
            +AddTH('NFe')
            +AddTH('Embalagem')
            +AddTH('Qtd.Enviada')
            +AddTH('Qtd.Devolvida')
            +AddTH('Qtd.Pendente')
            +AddTH('Valor Pendente')
            +AddTH('Situação')
            +'</tr> ';

    QryEmbalagensCli.First;
    while not QryEmbalagensCli.Eof do
    begin
      if QryEmbalagensCliValorPendente.AsFloat = 0 then
      begin
        QryEmbalagensCli.Next;
        Continue;
      end;

      if GetStatusNota = snAVencer then
        Result:= Result+'<tr style="font-weight:bold">'
      else if GetStatusNota = snVencido then
        Result:= Result+'<tr style="background-color:yellow;font-weight:bold">'
      else
        Result:= Result+'<tr> ';

      Result:= Result
           +AddTD(DateToStr(QryEmbalagensCliDATACOMPROVANTE.AsDateTime), taCenter)
           +AddTD(DateToStr(QryEmbalagensCliDataVencimento.AsDateTime), taCenter)
           +AddTD(QryEmbalagensCliNumero.AsString+'-'+QryEmbalagensCliSerie.AsString,taLeftJustify)
           +AddTD(QryEmbalagensCliApresentacao.AsString,taLeftJustify)
           +AddTD(QryEmbalagensCliQUANTATENDIDA.AsString,taCenter)
           +AddTD(IntToStr(QryEmbalagensCliQuantDevolvida.AsInteger),taCenter)
           +AddTD(QryEmbalagensCliQuantPendente.AsString, taCenter)
           +AddTD(QryEmbalagensCliValorPendente.DisplayText, taCenter)
           +AddTD(StatusNotaAsString(GetStatusNota), taLeftJustify)+'</tr>';

      QryEmbalagensCli.Next;
    end;
    Result:= Result+'</table>';
  end;

begin
  Result:= StringReplace(AText, '%NOMECLIENTE%', QryEmbalagensCliRAZAOSOCIAL.AsString, [rfReplaceAll, rfIgnoreCase]);
  Result:= StringReplace(Result, '%EMBALAGENSPENDENTES%', GetTabelaEmbalagensPendentes, [rfReplaceAll, rfIgnoreCase]);
//  Result:= StringReplace(Result, '%EMBALAGENSAVENCER%', GetTabelaEmbalagensAVencer, [rfReplaceAll, rfIgnoreCase]);
end;

end.
