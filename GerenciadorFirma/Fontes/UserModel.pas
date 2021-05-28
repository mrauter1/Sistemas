unit UserModel;

interface

uses
  Ladder.ORM.ModeloBD, Ladder.ORM.Dao, System.SysUtils, System.Classes, System.Generics.Collections;

type
  TPermissaoMenus = class
  public
    UserID: Integer;
    MenuName: String;
    Permitido: Boolean;
  end;

  TPermissaoConsultas = class
  public
    UserID: Integer;
    ConsultaID: Integer;
    Permitido: Boolean;
  end;

  TUsuario = class
  public
    UserID: Integer;
    Nome: String;
    Senha: String;
    admin: Boolean;
    DefaultMenu: String;
    Producao: Boolean;
    Desenvolvedor: Boolean;
    CodSidicom: String;
    CodVendedor: String;
    PermissaoMenus: TObjectList<TPermissaoMenus>;
    PermissaoConsultas: TObjectList<TPermissaoConsultas>;
  end;

  TUsuarioDao = class(TDaoGeneric<TUsuario>, IDaoGeneric<TUsuario>)
  private
    FPermissaoMenusDao: IDaoGeneric<TPermissaoMenus>;
    FPermissaConsultasDao: IDaoGeneric<TPermissaoConsultas>;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TUsuarioDao }

constructor TUsuarioDao.Create;
begin
  inherited Create('perm.Usuario', 'userid', TUsuario, amPublicAndPublished);

  FPermissaoMenusDao:= TDaoGeneric<TPermissaoMenus>.Create('perm.Menus', 'MenuName', TPermissaoMenus, amPublicAndPublished);
  AddChildDao('PermissaoMenus', 'userid', 'userid', FPermissaoMenusDao);

  FPermissaConsultasDao:= TDaoGeneric<TPermissaoConsultas>.Create('perm.Consultas', 'ConsultaID', TPermissaoConsultas, amPublicAndPublished);
  AddChildDao('PermissaoConsultas', 'userid', 'userid', FPermissaConsultasDao);
end;

destructor TUsuarioDao.Destroy;
begin

  inherited;
end;

end.
