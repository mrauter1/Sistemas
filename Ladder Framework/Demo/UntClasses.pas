unit UntClasses;

interface

uses
  System.Classes;

type
  TAvisoAutomatico = class(TPersistent)
  private
    FTitulo: String;
    FID: Integer;
    FMensagem: String;
    FNome: String;
  published
    property ID: Integer read FID write FID;
    property Nome: String read FNome write FNome;
    property Titulo: String read FTitulo write FTitulo;
    property Mensagem: String read FMensagem write FMensagem;
  end;

type
   TCampo = class(TPersistent)
  private
    FVisivel: Boolean;
    FID: Integer;
    FNomeCampo: String;
    FConsulta: Integer;
    FFormatacao: Integer;
    FTamanhoCampo: Integer;
   published
     property ID: Integer read FID write FID;
     property Consulta: Integer read FConsulta write FConsulta;
     property NomeCampo: String read FNomeCampo write FNomeCampo;
     property TamanhoCampo: Integer read FTamanhoCampo write FTamanhoCampo;
     property Visivel: Boolean read FVisivel write FVisivel;
     property Formatacao: Integer read FFormatacao write FFormatacao;
   end;



implementation



end.
