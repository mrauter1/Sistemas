unit Test.MockClasses;

interface

uses
  Generics.Collections;

type
  TMFor = class
  private
    FChaveNF: String;
    FSerie: String;
    FNumero: String;
    FCodComprovante: String;
    FDataComprovante: TDateTime;
    FCodFilial: String;
  published
    property ChaveNF: String read FChaveNF write FChaveNF;
    property CodFilial: String read FCodFilial write FCodFilial;
    property CodComprovante: String read FCodComprovante write FCodComprovante;
    property Serie: String read FSerie write FSerie;
    property Numero: String read FNumero write FNumero;
    property DataComprovante: TDateTime read FDataComprovante write FDataComprovante;
  end;

  TTestChild = class
  private
    FNum: Integer;
    FID: Integer;
  public
    constructor Create(pNum: Integer); overload;
    constructor Create(pNum: Integer; pTexto: String); overload;
  published
    property ID: Integer read FID write FID;
    property Num: Integer read FNum write FNum;
  end;

  TTeste = class
  private
    FID: Integer;
    FFloat: Double;
    FTexto: String;
    FData: TDateTime;
    FChilds: TObjectList<TTestChild>;
  public
    constructor Create; overload;
    constructor Create(pTexto: String; pData: TDateTime; pFloat: Double); overload;
  published
    destructor Destroy;
    property ID: Integer read FID write FID;
    property Texto: String read FTexto write FTexto;
    property Data: TDateTime read FData write FData;
    property Float: Double read FFloat write FFloat;
    property Childs: TObjectList<TTestChild> read FChilds write FChilds;
  end;

  TTesteComposite = class(TTeste)
  public
    FNumber: Double;
    FIsCool: Boolean;
  published
    constructor Create(pTexto: String; pData: TDateTime; pFloat: Double; pNumber: Double; pIsCool: Boolean); overload;
    property Number: Double read FNumber write FNumber;
    property IsCool: Boolean read FIsCool write FIsCool;
  end;

implementation

{ TTeste }

constructor TTeste.Create(pTexto: String; pData: TDateTime; pFloat: Double);
begin
  Create;
  Texto:= pTexto;
  Data:= pData;
  Float:= pFloat;
end;

constructor TTeste.Create;
begin
  inherited Create;
  FChilds:= TObjectList<TTestChild>.Create(True);
end;

destructor TTeste.Destroy;
begin
  FChilds.Free;
  inherited Destroy;
end;

{ TTestChild }

constructor TTestChild.Create(pNum: Integer);
begin
  inherited Create;
  Num:= pNum;
end;

constructor TTestChild.Create(pNum: Integer; pTexto: String);
begin
  Create(pNum);
end;

{ TTesteComposite }

constructor TTesteComposite.Create(pTexto: String; pData: TDateTime; pFloat,
  pNumber: Double; pIsCool: Boolean);
begin
  inherited Create(pTexto, pData, pFloat);
  FNumber:= pNumber;
  FIsCool:= pIsCool;
end;

end.
