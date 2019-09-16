unit uDataModule1;

interface

uses
  SysUtils, Classes, DB, DBClient;

type
  TDataModule1 = class(TDataModule)
    CdsOrcamento: TClientDataSet;
    CdsOrcamentoPro: TClientDataSet;
    CdsOrcamentoNumero: TStringField;
    CdsOrcamentoDATA: TDateTimeField;
    CdsOrcamentoPRAZO: TStringField;
    CdsOrcamentoFRETE: TStringField;
    CdsOrcamentoENTREGA: TStringField;
    CdsOrcamentoOBSERVACAO: TStringField;
    CdsOrcamentoEMPNOME: TStringField;
    CdsOrcamentoEMPFONE: TStringField;
    CdsOrcamentoEMPFAX: TStringField;
    CdsOrcamentoEMPCEP: TStringField;
    CdsOrcamentoEMPCNPJ: TStringField;
    CdsOrcamentoEMPIE: TStringField;
    CdsOrcamentoVENNOME: TStringField;
    CdsOrcamentoVENFONE: TStringField;
    CdsOrcamentoVENEMAIL: TStringField;
    CdsOrcamentoCLINOME: TStringField;
    CdsOrcamentoCLIENDERECO: TStringField;
    CdsOrcamentoEMPENDERECO: TStringField;
    CdsOrcamentoCLICONTATO: TStringField;
    CdsOrcamentoCLIEMAIL: TStringField;
    CdsOrcamentoProNUMERO: TStringField;
    CdsOrcamentoProNOME: TStringField;
    CdsOrcamentoProEMBALAGEM: TStringField;
    CdsOrcamentoProVALOR: TFloatField;
    CdsOrcamentoProSITTRIB: TStringField;
    CdsOrcamentoProIPI: TStringField;
    CdsOrcamentoProICMS: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  CdsOrcamento.CreateDataSet;
  CdsOrcamento.Open;
end;

procedure TDataModule1.DataModuleDestroy(Sender: TObject);
begin
  CdsOrcamento.Close;
end;

end.
