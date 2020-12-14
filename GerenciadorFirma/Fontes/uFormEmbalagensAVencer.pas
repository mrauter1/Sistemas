unit uFormEmbalagensAVencer;

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

  TFormEmbalagensAVencer = class(TForm)
    cxGridEmbalagens: TcxGrid;
    cxGridViewEmbalagens: TcxGridDBTableView;
    cxGridEmbalagensLevel: TcxGridLevel;

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
    cxGridViewEmbalagensDataVencimento: TcxGridDBColumn;
    BtnEnviarEmail: TButton;
    cxGridViewEmbalagensVALTOTAL: TcxGridDBColumn;
    cxGridViewEmbalagensVALUNIDADE: TcxGridDBColumn;
    cxGridViewEmbalagensQuantDevolvida: TcxGridDBColumn;
    PanelTop: TPanel;
    EditEmails: TEdit;
    Label2: TLabel;
    BtnContatos: TButton;
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
    cxGridViewEmbalagensValorPendente: TcxGridDBColumn;
    QryTextoEmailCorpo: TMemoField;
    QryAVencer: TFDQuery;
    QryAVencerchavenfpro: TStringField;
    QryAVencerDESCSTATUS: TStringField;
    QryAVencercodcliente: TStringField;
    QryAVencerstatus: TIntegerField;
    QryAVencerRAZAOSOCIAL: TStringField;
    QryAVencerCIDADE: TStringField;
    QryAVencerdatacomprovante: TDateField;
    QryAVencerDataVencimento: TDateField;
    QryAVencernumero: TStringField;
    QryAVencerserie: TStringField;
    QryAVencercodproduto: TStringField;
    QryAVencerapresentacao: TStringField;
    QryAVencerQuantAtendida: TBCDField;
    QryAVencerCHAVENF: TStringField;
    QryAVencerTOTPAGO: TFMTBCDField;
    QryAVencerVALTOTAL: TBCDField;
    QryAVencerEntregaParcial: TStringField;
    QryAVencerVALUNIDADE: TFMTBCDField;
    QryAVencerQuantDevolvida: TFMTBCDField;
    QryAVencerQuantPendente: TFMTBCDField;
    QryAVencerValorPendente: TFMTBCDField;
    QryAVencerDiasParaVencimento: TIntegerField;
    DSAVencer: TDataSource;
    QryAVencerENVIADOAVENCER: TBooleanField;
    QryAVencerSATUSAVENCER: TStringField;
    cxGridViewEmbalagensSATUSAVENCER: TcxGridDBColumn;
    cxGridViewEmbalagensstatus: TcxGridDBColumn;
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
    FDataMaxVencimento: TDateTime;
    FSqlQryAVencer: String;
    FListaEmbalagensRecentes: TList<String>;
    FMailSender: TMailSender;
    FormShowMemo: TFormShowMemo;
    FIdentificador: String;
    procedure EviarEmailCliente(AEmailDestino: String; ACopyToSelf: Boolean = True);
    procedure AtualizaEmails;
    function ReplaceWildcards(AText: String): String;
    function GetStatusNota(ADataVencimento: TDateTime): TStatusNota;
    function StatusNotaAsString(AStatus: TStatusNota): string;
    procedure MarcarEmbalagensAVencerComoEnviadas;
    function VerificarConsistenciaDevolucao: Boolean;
  public
    EmailEnviado: Boolean;
    function EnviaEmailAVencer: Boolean;
    procedure EnviaEmailTeste(AEmailDestino: String);
    procedure CarregaEmbalagensAVencer(ACodCliente: string; ADataMaxVencimento: TDateTime);
    class procedure AbreEmbalagensAVencer(ACodCliente: String; AIdentificador: String; ADataMaxVencimento: TDate);
    class procedure IgnoraEmbalagem(AChaveNFPRo: String); static;
  end;

var
  FormEmbalagensAVencer: TFormEmbalagensAVencer;

implementation

uses
  IdMessageBuilder, IdAttachmentMemory, uFormSelecionaEmailCliente, uFormAjustaInconsistencias;

{$R *.dfm}

class procedure TFormEmbalagensAVencer.AbreEmbalagensAVencer(
  ACodCliente: String; AIdentificador: String; ADataMaxVencimento: TDate);
var
  FFrm: TFormEmbalagensAVencer;
begin
  FFrm:= TFormEmbalagensAVencer.Create(nil);
  try
    FFrm.CarregaEmbalagensAVencer(ACodCliente, ADataMaxVencimento);
    FFrm.ShowModal;
  finally
    FFrm.Free;
  end;
end;

procedure TFormEmbalagensAVencer.BtnAtualizarClick(Sender: TObject);
begin
  CarregaEmbalagensAVencer(FCodCliente, FDataMaxVencimento);
end;

procedure TFormEmbalagensAVencer.AtualizaEmails;
  function getSql(ACodCliente, EmailEmbalagem: String): String;
  begin
    Result:= 'IF EXISTS(SELECT * FROM CLIENTEEMBALAGEM WHERE CODCLIENTE = '''+ACodCliente+''') '
            +Format('  UPDATE ClienteEmbalagem set EmailEmbalagem = ''%s'' where CodCliente = ''%s'' ',[EmailEmbalagem, ACodCliente])
            +' ELSE '
            +Format('INSERT INTO ClienteEmbalagem (CodCliente, EmailEmbalagem) values (''%s'', ''%s'') ', [ACodCliente, EmailEmbalagem]);
  end;
begin
  ConSqlServer.ExecutaComando(getSql(QryAVencercodcliente.AsString, EditEmails.Text));
end;

procedure TFormEmbalagensAVencer.BtnContatosClick(Sender: TObject);
begin
  EditEmails.Text:= TFormSelecionaEmailCliente.SelecionaEmailContatos(QryAVencercodcliente.AsString, EditEmails.Text);
  AtualizaEmails;
end;

procedure TFormEmbalagensAVencer.BtnEnviarEmailClick(Sender: TObject);
begin
  if Trim(EditEmails.Text) = '' then
  begin
    ShowMessage('É preciso indicar um email para enviar!');
    EditEmails.SetFocus;
    Exit;
  end;
  EnviaEmailAVencer;
end;

procedure TFormEmbalagensAVencer.CarregaEmbalagensAVencer(ACodCliente: string; ADataMaxVencimento: TDateTime);
var
  FSql: string;

  function GetFiltro: String;
  begin
    Result:= ' ';
    if CheckBoxMostrarIgnorados.Checked = False then
      Result:= ' AND IsNull(Status,0) <> 2 ';
  end;

begin
  FIdentificador:= 'AVENCER';
  FCodCliente:= ACodCliente;
  FDataMaxVencimento:= ADataMaxVencimento;

  FSql:= FSqlQryAVencer;
  if CheckBoxMostrarIgnorados.Checked = False then
    FSql:= FSql.Replace('/*Ignorados*/', GetFiltro);

  QryAVencer.Close;
  QryAVencer.SQL.Text:= FSql;
  QryAVencer.ParamByName('CodCliente').AsString:= FCodCliente;
  QryAVencer.ParamByName('DataFim').AsDate:= ADataMaxVencimento;
  QryAVencer.Open;

  QryTextoEmail.Close;
  QryTextoEmail.ParamByName('Identificador').AsString:= FIdentificador;
  QryTextoEmail.Open;

  Self.Caption:= 'Embalagens a vencer do cliente '+QryAVencerRAZAOSOCIAL.AsString;
  EditEmails.Text:= ConSqlServer.RetornaValor(Format('SELECT EmailEmbalagem from ClienteEmbalagem where CodCliente = ''%s'' ',[ACodCliente]), '');
end;

procedure TFormEmbalagensAVencer.CheckBoxMostrarIgnoradosClick(
  Sender: TObject);
begin
  CarregaEmbalagensAVencer(FCodCliente, FDataMaxVencimento);
end;

procedure TFormEmbalagensAVencer.cxGridViewClientesStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if Sender.DataController.Values[ARecord.RecordIndex, cxGridViewEmbalagensSTATUS.Index] = 2 then
    AStyle := cxStyleAmarelo;
end;

procedure TFormEmbalagensAVencer.DeixardeIgnorarEmbalagem1Click(
  Sender: TObject);
const
  cSqlDelete = 'DELETE FROM MCLIPROSTATUSRECB WHERE CHAVENFPRO= ''%s'' ';
begin
  ConSqlServer.ExecutaComando(Format(cSqlDelete, [QryAVencerChaveNFPro.AsString]));
  QryAVencer.Refresh;
end;

procedure TFormEmbalagensAVencer.EviarEmailCliente(AEmailDestino: String; ACopyToSelf: Boolean = True);
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
    FormShowMemo.SetText('Enviando email para o cliente '+QryAVencerRAZAOSOCIAL.AsString);

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

function TFormEmbalagensAVencer.VerificarConsistenciaDevolucao: Boolean;
begin
  Result:= False;
  QryAVencer.First;
  while not QryAVencer.Eof do
  begin
    TFormAjustaInconsistencias.VerificaEAjustaInconsistenciaEmbalagem(QryAVencerChaveNF.AsString);
    if TFormAjustaInconsistencias.NotaEmbalagemInconsistente(QryAVencerChaveNF.AsString) then
    begin
      ShowMessage(Format('Inconsistência ainda existe, email para o cliente %s não será enviado até as inconsistências serem resolvidas.',
                            [QryAVencerRazaoSocial.AsString]));
      Exit;
    end;

    QryAVencer.Next;
  end;
  QryAVencer.Refresh;
  Result:= True;
end;

function TFormEmbalagensAVencer.EnviaEmailAVencer: Boolean;
begin
  Result:= False;
  if QryAVencer.RecordCount = 0 then
    Exit;

  if VerificarConsistenciaDevolucao = False then
    Exit;

//  EviarEmailCliente('marcelo@rauter.com.br', False);
  EviarEmailCliente(EditEmails.Text, True);

  MarcarEmbalagensAVencerComoEnviadas;
  EmailEnviado:= True;
  Result:= True;
end;

procedure TFormEmbalagensAVencer.EnviaEmailTeste(AEmailDestino: String);
begin
  EviarEmailCliente(AEmailDestino, False);
end;

procedure TFormEmbalagensAVencer.MarcarEmbalagensAVencerComoEnviadas;
const
  cSqlStatus = 'exec SetAVencerMCLIPROSTATUSRECB ''%s'', %d';
begin
  QryAVencer.First;
  while not QryAVencer.Eof do
  begin
    ConSqlServer.ExecutaComando(Format(cSqlStatus, [QryAVencerChaveNFPro.AsString, 1]));
    QryAVencer.Next;
  end;
end;

procedure TFormEmbalagensAVencer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  AtualizaEmails;
end;

procedure TFormEmbalagensAVencer.FormCreate(Sender: TObject);
begin
  EmailEnviado:= False;
  FormShowMemo:= TFormShowMemo.Create(Self);

  QryEmail.Open;
  QryImagemEmail.Open;
  FMailSender:= TMailSender.Create(Self, QryEmailSMTPServer.AsString, QryEmailPort.AsInteger, QryEmailUsuario.AsString,
                  QryEmailPassword.AsString, QryEmailrequireAuth.AsBoolean, QryEmailUsuario.AsString);
  FListaEmbalagensRecentes:= TList<String>.Create;
  FSqlQryAVencer:= QryAVencer.SQL.Text;
end;

procedure TFormEmbalagensAVencer.FormDestroy(Sender: TObject);
begin
  FListaEmbalagensRecentes.Free;
end;

class procedure TFormEmbalagensAVencer.IgnoraEmbalagem(AChaveNFPRo: String);
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

procedure TFormEmbalagensAVencer.Ignorarembalagem1Click(Sender: TObject);
begin
  IgnoraEmbalagem(QryAVencerCHAVENFPRO.AsString);
  QryAVencer.Refresh;
end;

procedure TFormEmbalagensAVencer.PopupMenuPopup(Sender: TObject);
begin
  if QryAVencerCHAVENFPRO.AsString = '' then
    Exit;

  Ignorarembalagem1.Visible:=  QryAVencerSTATUS.AsInteger <> 2;
  DeixardeIgnorarEmbalagem1.Visible:= QryAVencerSTATUS.AsInteger = 2;
end;

function TFormEmbalagensAVencer.GetStatusNota(ADataVencimento: TDateTime): TStatusNota;
begin
  if ADataVencimento >= Trunc(Now)+14 then
    Result:= snPendente
  else if ADataVencimento >= Trunc(Now) then
    Result:= snAVencer
  else
    Result:= snVencido;
end;

function TFormEmbalagensAVencer.StatusNotaAsString(AStatus: TStatusNota): string;
begin
  case AStatus of
    snRecemEmitido: Result:= 'Enviado na última compra';
    snPendente: Result:= 'Pendente';
    snAVencer: Result:= 'A Vencer';
    snVencido: Result:= 'Vencido';
    else Result:= '';
  end;
end;

function TFormEmbalagensAVencer.ReplaceWildcards(AText: String): String;
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

  function GetTabelaEmbalagensAVencer: String;
  begin
    Result:= '';
    if (QryAVencer.Active = False) or (QryAVencer.IsEmpty) then
      Exit;
//      raise Exception.Create(Format('Não existem notas a vencer para o cliente cod. %s', [FCodCliente]));

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

    QryAVencer.First;
    while not QryAVencer.Eof do
    begin
      if QryAVencerValorPendente.AsFloat = 0 then
      begin
        QryAVencer.Next;
        Continue;
      end;

      if GetStatusNota(QryAVencerDataVencimento.AsDateTime) = snAVencer then
        Result:= Result+'<tr style="font-weight:bold">'
      else if GetStatusNota(QryAVencerDataVencimento.AsDateTime) = snVencido then
        Result:= Result+'<tr style="background-color:yellow;font-weight:bold">'
      else
        Result:= Result+'<tr> ';

      Result:= Result
           +AddTD(DateToStr(QryAVencerDATACOMPROVANTE.AsDateTime), taCenter)
           +AddTD(DateToStr(QryAVencerDataVencimento.AsDateTime), taCenter)
           +AddTD(QryAVencerNumero.AsString+'-'+QryAVencerSerie.AsString,taLeftJustify)
           +AddTD(QryAVencerApresentacao.AsString,taLeftJustify)
           +AddTD(QryAVencerQuantAtendida.AsString,taCenter)
           +AddTD(IntToStr(QryAVencerQuantDevolvida.AsInteger),taCenter)
           +AddTD(QryAVencerQuantPendente.AsString, taCenter)
           +AddTD(QryAVencerValorPendente.DisplayText, taCenter)
           +AddTD(StatusNotaAsString(GetStatusNota(QryAVencerDataVencimento.AsDateTime)), taLeftJustify)+'</tr>';

      QryAVencer.Next;
    end;
    Result:= Result+'</table>';
  end;

begin
  Result:= StringReplace(AText, '%NOMECLIENTE%', QryAVencerRAZAOSOCIAL.AsString, [rfReplaceAll, rfIgnoreCase]);
//  Result:= StringReplace(Result, '%EMBALAGENSPENDENTES%', GetTabelaEmbalagensPendentes, [rfReplaceAll, rfIgnoreCase]);
  Result:= StringReplace(Result, '%EMBALAGENSAVENCER%', GetTabelaEmbalagensAVencer, [rfReplaceAll, rfIgnoreCase]);
end;

end.
