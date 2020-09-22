unit uDmEstoqProdutos;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient, uFuncProbabilidades,
  Data.SqlExpr, System.Math, uFormProInfo, uFrmShowMemo, uPedidos, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  uConSqlServer, uAppConfig;

type
  TDmEstoqProdutos = class(TDataModule)
    QryEstoq: TFDQuery;
    QryEstoqCODPRODUTO: TStringField;
    QryEstoqAPRESENTACAO: TStringField;
    QryEstoqESTOQUEATUAL: TBCDField;
    QryEstoqROTACAO: TIntegerField;
    QryEstoqDEMANDAC1: TFMTBCDField;
    QryEstoqMediaSaida: TFMTBCDField;
    QryEstoqStdDev: TFloatField;
    QryEstoqDemandaDiaria: TBCDField;
    QryEstoqProbFalta: TBCDField;
    QryEstoqPercentDias: TFloatField;
    QryEstoqProbFaltaHoje: TFloatField;
    QryEstoqEstoqMaxCalculado: TFMTBCDField;
    QryEstoqESPACOESTOQUE: TIntegerField;
    QryEstoqNAOFAZESTOQUE: TBooleanField;
    QryEstoqPRODUCAOMINIMA: TIntegerField;
    QryEstoqSOMANOPESOLIQ: TBooleanField;
    QryEstoqDemanda: TFMTBCDField;
    QryEstoqDIASESTOQUE: TBCDField;
    QryEstoqFaltaConfirmada: TFMTBCDField;
    QryEstoqFaltaHoje: TFMTBCDField;
    QryEstoqFaltaTotal: TFMTBCDField;
    QryEstoqNUMPEDIDOS: TIntegerField;
    QryPedPro: TFDQuery;
    QryPedProCODPRODUTO: TStringField;
    QryPedProCODPEDIDO: TStringField;
    QryPedProDATAENTREGA: TDateField;
    QryPedProSITUACAO: TStringField;
    QryPedProNOMEPRODUTO: TStringField;
    QryPedProQUANTIDADE: TBCDField;
    QryPedProQUANTPENDENTE: TBCDField;
    QryPedProDIASPARAENTREGA: TIntegerField;
    QryPedProCODCLIENTE: TStringField;
    QryPedProNOMECLIENTE: TStringField;
    QryPedProCODTRANSPORTE: TStringField;
    QryPedProNOMETRANSPORTE: TStringField;
    QryEstoqCodAplicacao: TStringField;
    QryEstoqNOMEAPLICACAO: TStringField;
    QryEstoqRank: TLargeintField;
    procedure DataModuleCreate(Sender: TObject);
    procedure QryEstoqProbFaltaHojeGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
  public
    procedure AtualizaEstoqueNew;
  end;

var
  DmEstoqProdutos: TDmEstoqProdutos;
  DataSistema: TDateTime;

const
  cArquivoCdsEstoqProdutos = 'CdsEstoqProdutos.xml';

implementation

uses
  GerenciadorUtils, Utils;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TDmEstoqProdutos }

procedure TDmEstoqProdutos.AtualizaEstoqueNew;
begin
  QryEstoq.DisableControls;
  try
    if QryEstoq.Active then
      QryEstoq.Close;

    QryEstoq.Open;

    QryPedPro.DisableControls;
    try
      if QryPedPro.Active then
        QryPedPro.Close;

      QryPedPro.Open;
    finally
      QryPedPro.EnableControls;
    end;

  finally
    QryEstoq.EnableControls;
  end;
end;

procedure TDmEstoqProdutos.DataModuleCreate(Sender: TObject);
begin
  DataSistema:= now;//StrToDateTime('20.09.2013');
end;

procedure TDmEstoqProdutos.QryEstoqProbFaltaHojeGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);

  function FormataFieldPercentual(Sender: TField): String;
  begin
    Result:= FormatFloat('###0.00', Sender.AsFloat*100)+' %';
  end;
begin
  Text:= FormataFieldPercentual(Sender);
end;

end.
