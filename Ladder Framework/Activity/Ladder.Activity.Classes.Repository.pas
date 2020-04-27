unit Ladder.Activity.Classes.Repository;

interface

uses
  Ladder.Activity.Classes, Ladder.ORM.Repository;

type
  TOnGetMasterID = function (pObject: TObject): Integer of object;

  TParameterRepository = class(TFrwRepository<TParameter>)
  private
    FOnGetMasterID: TOnGetMasterID;
  public
    constructor Create(pNomeTabela: String; pOnGetMasterID: TOnGetMasterID);
    property OnGetMasterID: TOnGetMasterID read FOnGetMasterID write FOnGetMasterID;
  end;

  TProcessoRepository = class(TFrwRepository<TProcessoBase>)
    constructor Create;

  end;

implementation

{ TProcessoRepository }

constructor TProcessoRepository.Create;
begin
  inherited Create('Processo', 'ID');
end;

{ TParameterRepository }

constructor TParameterRepository.Create(pNomeTabela: String; pOnGetMasterID: TOnGetMasterID);
begin
  inherited Create(pNomeTabela, 'ID');
  FOnGetMasterID:= pOnGetMasterID;
end;

end.
