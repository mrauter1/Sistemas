unit uConFirebird;

interface

uses
  System.SysUtils, System.Classes, uDmConnection, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDmConnection1 = class(TDmConnection)
    SqlEmpresa: TFDQuery;
    SqlEmpresaCODCLIENTE: TStringField;
    SqlEmpresaCODVENDEDOR: TStringField;
    SqlEmpresaCODVENDEDOR2: TStringField;
    SqlEmpresaCODVENDEDOR3: TStringField;
    SqlEmpresaCODREGIAO: TStringField;
    SqlEmpresaCODSUBREGIAO: TStringField;
    SqlEmpresaCODROTEIRO: TStringField;
    SqlEmpresaCODROTEIROSUB: TStringField;
    SqlEmpresaCODTIPOCLI: TStringField;
    SqlEmpresaFILIALCLIENTE: TStringField;
    SqlEmpresaSITUACAOCLI: TStringField;
    SqlEmpresaCLASSECLI: TStringField;
    SqlEmpresaNOMECLIENTE: TStringField;
    SqlEmpresaRAZAOSOCIAL: TStringField;
    SqlEmpresaBAIRRO: TStringField;
    SqlEmpresaCIDADE: TStringField;
    SqlEmpresaESTADO: TStringField;
    SqlEmpresaCODIGOPOSTAL: TStringField;
    SqlEmpresaNUMEROCGCMF: TStringField;
    SqlEmpresaNUMEROINSC: TStringField;
    SqlEmpresaNUMEROISSQN: TStringField;
    SqlEmpresaNUMEROCPF: TStringField;
    SqlEmpresaPESSOA: TStringField;
    SqlEmpresaCODBANCO: TStringField;
    SqlEmpresaPRACACIDADE: TStringField;
    SqlEmpresaPRACAESTADO: TStringField;
    SqlEmpresaPRACACEP: TStringField;
    SqlEmpresaENTREGACIDADE: TStringField;
    SqlEmpresaENTREGAESTADO: TStringField;
    SqlEmpresaENTREGACEP: TStringField;
    SqlEmpresaCODTRANSPORTADORA: TStringField;
    SqlEmpresaLIMITECREDITO: TBCDField;
    SqlEmpresaCODCONDICAO: TStringField;
    SqlEmpresaDATAULTIMACOMPRA: TDateField;
    SqlEmpresaDATAINCLUSAO: TDateField;
    SqlEmpresaCODLISTAPRECO: TStringField;
    SqlEmpresaTEMCONVENIO: TStringField;
    SqlEmpresaOBSERVACAO: TMemoField;
    SqlEmpresaCLISENTOICM: TStringField;
    SqlEmpresaCLISENTOSUBST: TStringField;
    SqlEmpresaCLISENTOIPI: TStringField;
    SqlEmpresaCONTRIBUINTE: TStringField;
    SqlEmpresaCONTRIBUINTEBOX: TStringField;
    SqlEmpresaCLISENTOICM8702: TStringField;
    SqlEmpresaOBSDANOTA: TStringField;
    SqlEmpresaCODDOMEDICO: TStringField;
    SqlEmpresaDIAMAISVENCIMENTO: TIntegerField;
    SqlEmpresaCODIGOAUXILIAR: TStringField;
    SqlEmpresaPRACABAIRRO: TStringField;
    SqlEmpresaENTREGABAIRRO: TStringField;
    SqlEmpresaCOBRABLOQUETO: TStringField;
    SqlEmpresaDESCONTODECANAL: TCurrencyField;
    SqlEmpresaMICROEMPRESA: TStringField;
    SqlEmpresaSIMPLESESTADUAL: TStringField;
    SqlEmpresaTIPOFRETECLI: TStringField;
    SqlEmpresaNAOPROTESTAR: TStringField;
    SqlEmpresaINCLUIDOVIAPALM: TStringField;
    SqlEmpresaDESATIVADIASCOMPRA: TIntegerField;
    SqlEmpresaLOGRADOURO: TStringField;
    SqlEmpresaLOGNUMERO: TStringField;
    SqlEmpresaLOGCOMPL: TStringField;
    SqlEmpresaPRACALOGRADOURO: TStringField;
    SqlEmpresaPRACALOGNUMERO: TStringField;
    SqlEmpresaPRACALOGCOMPL: TStringField;
    SqlEmpresaENTREGALOGRADOURO: TStringField;
    SqlEmpresaENTREGALOGNUMERO: TStringField;
    SqlEmpresaENTREGALOGCOMPL: TStringField;
    SqlEmpresaENDERECO: TStringField;
    SqlEmpresaPRACAENDERECO: TStringField;
    SqlEmpresaENTREGAENDERECO: TStringField;
    SqlEmpresaCODCLIENTEMATRIZ: TStringField;
    SqlEmpresaCLISENTOPISCOFINS: TStringField;
    SqlEmpresaCODPAIS: TStringField;
    SqlEmpresaDATAVENCELIMITE: TDateField;
    SqlEmpresaPEDIDOMINIMO: TBCDField;
    SqlEmpresaCODCOMPROVANTE: TStringField;
    SqlEmpresaDATAALTERACAO: TSQLTimeStampField;
    SqlEmpresaCODVENDEDOR4: TStringField;
    SqlEmpresaCODVENDEDOR5: TStringField;
    SqlEmpresaNUMEROSUFRAMA: TStringField;
    SqlEmpresaDESCONTAICMSPRO_SN: TStringField;
    SqlEmpresaNIVEL_TABELA_PISCOF: TStringField;
    SqlEmpresaINDPRES: TSmallintField;
    SqlEmpresaIDESTRANGEIRO: TStringField;
    SqlEmpresaCONSUMIDOR_FINAL: TIntegerField;
    SqlEmpresaINDIEDEST: TSmallintField;
    SqlEmpresaEXCEDEU_SUBLIMITE_SIMPLES_SN: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmConnection1: TDmConnection1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
