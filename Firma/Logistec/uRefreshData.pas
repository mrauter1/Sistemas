unit uRefreshData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uDmFDConnection,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, uDmSqlUtils,
  FireDAC.Comp.BatchMove, FireDAC.Comp.BatchMove.DataSet,
  Ladder.Activity.LadderVarToSql, Ladder.ORM.DaoUtils,SynCommons, SynTable;

type
  TFrmRefreshData = class(TForm)
    Memo1: TMemo;
    QryFirebird: TFDQuery;
    FDTable1: TFDTable;
    Panel1: TPanel;
    EditNomeTabela: TEdit;
    Button1: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DataSource: TDataSource;
    Button2: TButton;
    FDBatchMove: TFDBatchMove;
    FDTableResult: TFDTable;
    QryResultFb: TFDQuery;
    FDTableResultcodcliente: TStringField;
    FDTableResultrazaosocial: TStringField;
    FDTableResultobservacao: TWideMemoField;
    QryFirebirdCODCLIENTE: TStringField;
    QryFirebirdOBSERVACAO: TMemoField;
    QryResultFbCODCLIENTE: TStringField;
    QryResultFbOBSERVACAO: TMemoField;
    Label1: TLabel;
    QrySqlServer: TFDQuery;
    StringField1: TStringField;
    MemoField1: TMemoField;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure ResetQueries;
    procedure ResetQuery(pDataSet: TDataSet);
    function GetDaoUtils: TDaoUtils;
    procedure CreateAndPopulateParams(pQuery: TFDQuery;
      pDocVariant: TDocVariantData);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRefreshData: TFrmRefreshData;

implementation

{$R *.dfm}

uses
  DateUtils,  Ladder.ServiceLocator, Ladder.Activity.Classes, Ladder.ORM.FUnctions;

procedure TFrmRefreshData.Button1Click(Sender: TObject);
begin
//  ResetQuery(QryResultFB);
//  QryResultFb.Close;
//  QryResultFb.Open(Memo1.Lines.Text);
  ResetQuery(QrySqlServer);
  QrySqlServer.Close;
  QrySqlServer.Open(Memo1.Lines.Text);
  QrySqlServer.FetchAll;
end;

procedure TFrmRefreshData.ResetQuery(pDataSet: TDataSet);
begin
  if pDataSet.Active then
    pDataSet.Close;

  pDataSet.Fields.Clear;
  pDataSet.FieldDefs.Clear;
end;

procedure TFrmRefreshData.ResetQueries;
begin
  ResetQuery(QryFirebird);
  ResetQuery(FDTable1);

  ResetQuery(QrySqlServer);

  ResetQuery(QryResultFb);
  ResetQuery(FDTableResult);
end;

function TFrmRefreshData.GetDaoUtils: TDaoUtils;
begin
  Result:= TFrwServiceLocator.Context.DaoUtils;
end;

procedure TFrmRefreshData.CreateAndPopulateParams(pQuery: TFDQuery; pDocVariant: TDocVariantData);
var
  FieldNames: TRawUTF8DynArray;
  FieldTypes: TSQLDBFieldTypeDynArray;
  FieldValues: TRawUTF8DynArrayDynArray;
  FFieldCount: Integer;
  FFirstRow: PDocVariantData;

  procedure SetType(Col, Row: Integer; pValue: PVAriant);
  var
    FFieldType: TSQLDBFieldType;
  begin
    if FieldTypes[Col] = ftUTF8 then Exit; // If it is a string it does not need to be changed

    FFieldType:= VariantVTypeToSQLDBFieldType(VarType(pValue^));

    if FFieldType <= ftNull then  // if current col FieldType is ftnull or ftUnknown does not need to change
      Exit;

    if FieldTypes[Col] <= ftNull then
    begin
      if (FFieldType = ftUTF8) and (LadderVarIsIso8601(pValue^)) then
        FieldTypes[Col]:= ftDate
      else
        FieldTypes[Col]:= FFieldType;

      Exit;
    end;

    if FFieldType = FieldTypes[Col] then
      Exit
    else if Ord(FFieldType) > Ord(FieldTypes[Col]) then
      FieldTypes[Col]:= FFieldType
    else // Ord(FFieldType) < Ord(FieldTypes[Col]
      if FieldTypes[Col] = ftDate then // if current column fieldtype is int, double or currency and prior fieldtype was date, must change to string
        FieldTypes[Col]:= ftUTF8;
  end;

  procedure SetParamValue(Row, Col: Integer; FVar: PVariant);
  var
    basicType: Integer;
  begin
      if VarIsNull(FVar^) then
      begin
        pQuery.Params[Col].Values[Row]:= null;
        Exit;
      end;

      case FieldTypes[Col] of
        ftUnknown, ftNull:  pQuery.Params[Col].Values[Row]:= null;
        ftUTF8: pQuery.Params[Col].AsStrings[Row]:= VarToStr(FVar^);
        ftDate: pQuery.Params[Col].AsDateTimes[Row]:= LadderVarToDateTime(FVar^);
        ftInt64: pQuery.Params[Col].AsIntegers[Row]:= FVar^;
        ftDouble, ftCurrency: pQuery.Params[Col].AsFloats[Row]:= FVar^;
      else
        pQuery.Params[Col].Values[Row]:= FVar^;
      end;
  end;

var
  Col, Row: Integer;
  sStart, sFim: TDateTime;
  FCurOffset, FNumExecutions: Integer;

const
  cBatchSize = 500; // Optimum performance
begin
  if pDocVariant.Count=0 then
    Exit;

  FFirstRow:= @TDocVariantData(pDocVariant.Values[0]);
  FFieldCount:= Length(FFirstRow^.Values);

  SetLength(FieldTypes, FFieldCount);
  SetLength(FieldNames,FFieldCount);
  for Col := 0 to FFieldCount-1 do
  begin
//    pQuery.Params.CreateParam(data.DB.ftUnknown, FFirstRow^.Names[Col], ptInput);
    FieldTypes[Col]:= ftNull;
    FieldNames[Col]:= FFirstRow^.Names[Col];
  end;

//  SetLength(FieldValues, FFieldCount);
  for Col := 0 to FFieldCount-1 do
  begin
    for Row := 0 to pDocVariant.Count-1 do
      SetType(Col, Row, @pDocVariant._[Row].Values[Col]);

  end;

  for Col := 0 to FFieldCount-1 do
  begin
    case FieldTypes[Col] of
      ftUnknown, ftNull: pQuery.Params[Col].DataType:= Data.DB.ftByte; // Must have a tyoe
      ftUTF8: begin pQuery.Params[Col].DataType:= Data.DB.ftString; pQuery.Params[Col].FDDataType:= TFDDataType.dtWideString; end;
      ftDate: pQuery.Params[Col].DataType:= Data.DB.ftDateTime;
      ftInt64: pQuery.Params[Col].DataType:= Data.DB.ftInteger;
      ftDouble, ftCurrency: pQuery.Params[Col].DataType:= Data.DB.ftFloat;
    end;
    pQuery.Params[Col].ParamType:= ptInput;
  end;

{  for Col := 0 to FFieldCount-1 do
  begin
    for Row := 0 to pDocVariant.Count-1 do
      SetParamValue(Row, Col);

  end;         }

  sStart:= now;
//  pQuery.Prepare;
  DataModule1.FDConSqlServer.TxOptions.Isolation := xiDirtyRead;
  DataModule1.FDConSqlServer.TxOptions.AutoCommit:= False;
  DataModule1.FDConSqlServer.StartTransaction;
  try
    FCurOffset:= 0;
    while FCurOffset < pDocVariant.Count do
    begin
      FNumExecutions:= cBatchSize;

      if FNumExecutions+FCurOffset > pDocVariant.Count then
        FNumExecutions:= pDocVariant.Count-FCurOffset;

      pQuery.Params.ArraySize:= FNumExecutions;

      for Row := 0 to FNumExecutions-1 do
        for Col := 0 to FFieldCount-1 do
          SetParamValue(Row, Col, @pDocVariant._[Row+FCurOffset].Values[Col]);

      pQuery.Execute(FNumExecutions, 0);
      FCurOffset:= FCurOffset+cBatchSize;

    end;
  //  MultipleValuesInsert(Self, '##MFORTESTE', FieldNames, FieldTypes, pDocVariant.Count, FieldValues);

  finally
    DataModule1.FDConSqlServer.Commit;
    sFim:= now;
  end;
  ShowMessage(IntToStr(MilliSecondsBetween(sStart, sFim)));
//  Assert(False, IntToStr(MilliSecondsBetween(sStart, sFim)));
end;

procedure TFrmRefreshData.Button2Click(Sender: TObject);
var
  cfMapMemo: cfMapField;
  sStart, sEnd: TDateTime;
  FDocVar: TDocVariantData;
  FSql: String;
begin
  cfMapMemo.SourceType:= ftMemo;
  cfMapMemo.DestType:= Data.DB.ftBlob;

  ResetQueries;
{  QryFirebird.Sql.Text:= Memo1.Lines.Text;
  QryFirebird.Open;}

{  FDTable1.TableName:= EditNomeTabela.Text;
  TDmSqlUtils.CopyFieldDefs(FDTable1, QrySqlServer, [cfMapMemo]);}
//  FDTable1.CreateDataSet;
//  FDTable1.CreateTable(True);
                          {
  with TFDBatchMoveDataSetReader.Create(FDBatchMove) do begin
    DataSet := QrySqlServer;
    Optimise := True;
  end;
  with TFDBatchMoveDataSetWriter.Create(FDBatchMove) do begin
    DataSet := FDTable1;
    Optimise := True;
  end;}

  FDocVar:= TDocVariantData(GetDaoUtils.SelectAsDocVariant(Memo1.Lines.Text));
  FSql:= TLadderVarToSql.InsertSql(FDocVar, EditNomeTabela.Text);

  sStart:= now;
  QrySqlServer.SQL.Text:= FSql;
  CreateAndPopulateParams(QrySqlServer, FDocVar);
  sEnd:= now;

  ShowMessage(Fsql);                 {
  sStart:= now;
  FDBatchMove.Execute;




  ShowMessage(IntToStr(MilliSecondsBetween(sStart, sEnd)));
                                    {
  // show data in dbgrid
  QryResultFb.Sql.Text:= QryFirebird.SQL.Text;
  FDTableResult.TableName:= FDTable1.TableName;
  QryResultFb.Open;
  FDTableResult.Open;                }
end;

end.
