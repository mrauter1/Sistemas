unit uInterfacesTesteMVC;

interface

uses
  uMVCInterfaces;

type
  IPedidoCtrl = interface (ICadControle)
  ['{194D2E21-534B-4F3E-86E8-28432748257E}']
    function AbreCliente: Integer;
    function AbrePedidoItem: Integer;
  end;

  IClienteControle = interface (ICadControle)
  ['{45E9782F-C951-42F4-AAA6-8D22DC596122}']
  end;

  IPedidoItemControle = interface (ICadControle)
  ['{498D5CD8-0114-40C3-B13A-7E5F21383535}']
    function ConsultaProduto: string;
  end;

implementation

end.
