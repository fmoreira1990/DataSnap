unit uPessoa;

interface

uses
  System.Generics.Collections;

type
  TAcao = (tInsert, tEdit, TDelete);

  TEndereco = class
  private
    fidendereco: Int64;
    fdscep: string;
    fidpessoa: Int64;
  published
    property idendereco: Int64 read fidendereco write fidendereco;
    property idpessoa: Int64 read fidpessoa write fidpessoa;
    property dscep: string read fdscep write fdscep;
  end;

  TPessoa = class
  private
    fflnatureza: SmallInt;
    fnmprimeiro: string;
    fdtregistro: string;
    fnmsegundo: string;
    fdsdocumento: string;
    fidpessoa: Int64;
    fendereco: TEndereco;
  public
    destructor Destroy; override;
    constructor Create;
  published
    property idpessoa: Int64 read fidpessoa write fidpessoa;
    property flnatureza: SmallInt read fflnatureza write fflnatureza;
    property dsdocumento: string read fdsdocumento write fdsdocumento;
    property nmprimeiro: string read fnmprimeiro write fnmprimeiro;
    property nmsegundo: string read fnmsegundo write fnmsegundo;
    property dtregistro: string read fdtregistro write fdtregistro;
    property endereco: TEndereco read fendereco write fendereco;
  end;

  TEndereco_integracao = class
  private
    fnmcidade: string;
    fnmlogradouro: string;
    fidendereco: Int64;
    fnmbairro: string;
    fdsuf: string;
    fdscomplemento: string;
  published
    property idendereco: Int64 read fidendereco write fidendereco;
    property dsuf: string read fdsuf write fdsuf;
    property nmcidade: string read fnmcidade write fnmcidade;
    property nmbairro: string read fnmbairro write fnmbairro;
    property nmlogradouro: string read fnmlogradouro write fnmlogradouro;
    property dscomplemento: string read fdscomplemento write fdscomplemento;
  end;

  TListaPessoa = class
  private
    fpessoas: TObjectList<TPessoa>;
  public
    destructor Destroy; override;
    constructor Create;
  published
    property pessoas: TObjectList<TPessoa>read fpessoas write fpessoas;
  end;

  TListaEndereco_integracao = class
  private
    fenderecosIntegracao: TObjectList<TEndereco_integracao>;
  public
    destructor Destroy; override;
    constructor Create;
  published
    property enderecosIntegracao: TObjectList<TEndereco_integracao>read fenderecosIntegracao write fenderecosIntegracao;
  end;

  TListaEndereco = class
  private
    fenderecos: TObjectList<TEndereco>;
  public
    destructor Destroy; override;
    constructor Create;
  published
    property enderecos: TObjectList<TEndereco>read fenderecos write fenderecos;
  end;

implementation

{ TListaPessoa }

constructor TListaPessoa.Create;
begin
  inherited;
  fpessoas := TObjectList<TPessoa>.Create;
end;

destructor TListaPessoa.Destroy;
begin
  fpessoas.Destroy;
  inherited;
end;

{ TPessoa }

constructor TPessoa.Create;
begin
  inherited;
  fendereco := TEndereco.Create;
end;

destructor TPessoa.Destroy;
begin
  fendereco.Destroy;
  inherited;
end;

{ TListaEndereco }

constructor TListaEndereco.Create;
begin
  fEnderecos := TObjectList<TEndereco>.Create;
end;

destructor TListaEndereco.Destroy;
begin
  fEnderecos.Destroy;
  inherited;
end;

{ TListaEndereco_integracao }

constructor TListaEndereco_integracao.Create;
begin
  fenderecosIntegracao := TObjectList<TEndereco_integracao>.Create;
end;

destructor TListaEndereco_integracao.Destroy;
begin
  fenderecosIntegracao.Destroy;
  inherited;
end;

end.



