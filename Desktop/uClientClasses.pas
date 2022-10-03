//
// Created by the DataSnap proxy generator.
// 30/09/2022 23:18:26
// 

unit uClientClasses;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TControllerPessoaClient = class(TDSAdminRestClient)
  private
    FEchoStringCommand: TDSRestCommand;
    FReverseStringCommand: TDSRestCommand;
    FPessoaCommand: TDSRestCommand;
    FPessoaCommand_Cache: TDSRestCommand;
    FupdatePessoaCommand: TDSRestCommand;
    FacceptPessoaCommand: TDSRestCommand;
    FcancelPessoaCommand: TDSRestCommand;
    FEnderecoCommand: TDSRestCommand;
    FEnderecoCommand_Cache: TDSRestCommand;
    FupdateEnderecoCommand: TDSRestCommand;
    FacceptEnderecoCommand: TDSRestCommand;
    FcancelEnderecoCommand: TDSRestCommand;
    FEnderecoIntegracaoCommand: TDSRestCommand;
    FEnderecoIntegracaoCommand_Cache: TDSRestCommand;
    FupdateEnderecoIntegracaoCommand: TDSRestCommand;
    FacceptPessoasCommand: TDSRestCommand;
    FAfterConstructionCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string; const ARequestFilter: string = ''): string;
    function ReverseString(Value: string; const ARequestFilter: string = ''): string;
    function Pessoa(pIDPessoa: Int64; const ARequestFilter: string = ''): TJSONObject;
    function Pessoa_Cache(pIDPessoa: Int64; const ARequestFilter: string = ''): IDSRestCachedJSONObject;
    function updatePessoa(pIDPessoa: Int64; obj: TJSONValue; const ARequestFilter: string = ''): Boolean;
    function acceptPessoa(obj: TJSONValue; const ARequestFilter: string = ''): Boolean;
    function cancelPessoa(pIDPessoa: Int64; const ARequestFilter: string = ''): Boolean;
    function Endereco(pIDPessoa: Int64; const ARequestFilter: string = ''): TJSONObject;
    function Endereco_Cache(pIDPessoa: Int64; const ARequestFilter: string = ''): IDSRestCachedJSONObject;
    function updateEndereco(pIDEndereco: Int64; obj: TJSONValue; const ARequestFilter: string = ''): Boolean;
    function acceptEndereco(obj: TJSONValue; const ARequestFilter: string = ''): Boolean;
    function cancelEndereco(pIDEndereco: Int64; const ARequestFilter: string = ''): Boolean;
    function EnderecoIntegracao(pIDEndereco: Int64; const ARequestFilter: string = ''): TJSONObject;
    function EnderecoIntegracao_Cache(pIDEndereco: Int64; const ARequestFilter: string = ''): IDSRestCachedJSONObject;
    function AtualizaEnderecoIntegracao(const ARequestFilter: string = ''): Boolean;
    function acceptPessoas(obj: TJSONValue; const ARequestFilter: string = ''): Boolean;
    procedure AfterConstruction;
  end;

const
  TControllerPessoa_EchoString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TControllerPessoa_ReverseString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TControllerPessoa_Pessoa: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'pIDPessoa'; Direction: 1; DBXType: 18; TypeName: 'Int64'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONObject')
  );

  TControllerPessoa_Pessoa_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'pIDPessoa'; Direction: 1; DBXType: 18; TypeName: 'Int64'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TControllerPessoa_updatePessoa: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'pIDPessoa'; Direction: 1; DBXType: 18; TypeName: 'Int64'),
    (Name: 'obj'; Direction: 1; DBXType: 37; TypeName: 'TJSONValue'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TControllerPessoa_acceptPessoa: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'obj'; Direction: 1; DBXType: 37; TypeName: 'TJSONValue'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TControllerPessoa_cancelPessoa: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'pIDPessoa'; Direction: 1; DBXType: 18; TypeName: 'Int64'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TControllerPessoa_Endereco: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'pIDPessoa'; Direction: 1; DBXType: 18; TypeName: 'Int64'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONObject')
  );

  TControllerPessoa_Endereco_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'pIDPessoa'; Direction: 1; DBXType: 18; TypeName: 'Int64'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TControllerPessoa_updateEndereco: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'pIDEndereco'; Direction: 1; DBXType: 18; TypeName: 'Int64'),
    (Name: 'obj'; Direction: 1; DBXType: 37; TypeName: 'TJSONValue'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TControllerPessoa_acceptEndereco: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'obj'; Direction: 1; DBXType: 37; TypeName: 'TJSONValue'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TControllerPessoa_cancelEndereco: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'pIDEndereco'; Direction: 1; DBXType: 18; TypeName: 'Int64'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TControllerPessoa_EnderecoIntegracao: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'pIDEndereco'; Direction: 1; DBXType: 18; TypeName: 'Int64'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONObject')
  );

  TControllerPessoa_EnderecoIntegracao_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'pIDEndereco'; Direction: 1; DBXType: 18; TypeName: 'Int64'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TControllerPessoa_AtualizaEnderecoIntegracao: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TControllerPessoa_acceptPessoas: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'obj'; Direction: 1; DBXType: 37; TypeName: 'TJSONValue'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

implementation

function TControllerPessoaClient.EchoString(Value: string; const ARequestFilter: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FConnection.CreateCommand;
    FEchoStringCommand.RequestType := 'GET';
    FEchoStringCommand.Text := 'TControllerPessoa.EchoString';
    FEchoStringCommand.Prepare(TControllerPessoa_EchoString);
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.Execute(ARequestFilter);
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TControllerPessoaClient.ReverseString(Value: string; const ARequestFilter: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FConnection.CreateCommand;
    FReverseStringCommand.RequestType := 'GET';
    FReverseStringCommand.Text := 'TControllerPessoa.ReverseString';
    FReverseStringCommand.Prepare(TControllerPessoa_ReverseString);
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.Execute(ARequestFilter);
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TControllerPessoaClient.Pessoa(pIDPessoa: Int64; const ARequestFilter: string): TJSONObject;
begin
  if FPessoaCommand = nil then
  begin
    FPessoaCommand := FConnection.CreateCommand;
    FPessoaCommand.RequestType := 'GET';
    FPessoaCommand.Text := 'TControllerPessoa.Pessoa';
    FPessoaCommand.Prepare(TControllerPessoa_Pessoa);
  end;
  FPessoaCommand.Parameters[0].Value.SetInt64(pIDPessoa);
  FPessoaCommand.Execute(ARequestFilter);
  Result := TJSONObject(FPessoaCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TControllerPessoaClient.Pessoa_Cache(pIDPessoa: Int64; const ARequestFilter: string): IDSRestCachedJSONObject;
begin
  if FPessoaCommand_Cache = nil then
  begin
    FPessoaCommand_Cache := FConnection.CreateCommand;
    FPessoaCommand_Cache.RequestType := 'GET';
    FPessoaCommand_Cache.Text := 'TControllerPessoa.Pessoa';
    FPessoaCommand_Cache.Prepare(TControllerPessoa_Pessoa_Cache);
  end;
  FPessoaCommand_Cache.Parameters[0].Value.SetInt64(pIDPessoa);
  FPessoaCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONObject.Create(FPessoaCommand_Cache.Parameters[1].Value.GetString);
end;

function TControllerPessoaClient.updatePessoa(pIDPessoa: Int64; obj: TJSONValue; const ARequestFilter: string): Boolean;
begin
  if FupdatePessoaCommand = nil then
  begin
    FupdatePessoaCommand := FConnection.CreateCommand;
    FupdatePessoaCommand.RequestType := 'POST';
    FupdatePessoaCommand.Text := 'TControllerPessoa."updatePessoa"';
    FupdatePessoaCommand.Prepare(TControllerPessoa_updatePessoa);
  end;
  FupdatePessoaCommand.Parameters[0].Value.SetInt64(pIDPessoa);
  FupdatePessoaCommand.Parameters[1].Value.SetJSONValue(obj, FInstanceOwner);
  FupdatePessoaCommand.Execute(ARequestFilter);
  Result := FupdatePessoaCommand.Parameters[2].Value.GetBoolean;
end;

function TControllerPessoaClient.acceptPessoa(obj: TJSONValue; const ARequestFilter: string): Boolean;
begin
  if FacceptPessoaCommand = nil then
  begin
    FacceptPessoaCommand := FConnection.CreateCommand;
    FacceptPessoaCommand.RequestType := 'POST';
    FacceptPessoaCommand.Text := 'TControllerPessoa."acceptPessoa"';
    FacceptPessoaCommand.Prepare(TControllerPessoa_acceptPessoa);
  end;
  FacceptPessoaCommand.Parameters[0].Value.SetJSONValue(obj, FInstanceOwner);
  FacceptPessoaCommand.Execute(ARequestFilter);
  Result := FacceptPessoaCommand.Parameters[1].Value.GetBoolean;
end;

function TControllerPessoaClient.cancelPessoa(pIDPessoa: Int64; const ARequestFilter: string): Boolean;
begin
  if FcancelPessoaCommand = nil then
  begin
    FcancelPessoaCommand := FConnection.CreateCommand;
    FcancelPessoaCommand.RequestType := 'GET';
    FcancelPessoaCommand.Text := 'TControllerPessoa.cancelPessoa';
    FcancelPessoaCommand.Prepare(TControllerPessoa_cancelPessoa);
  end;
  FcancelPessoaCommand.Parameters[0].Value.SetInt64(pIDPessoa);
  FcancelPessoaCommand.Execute(ARequestFilter);
  Result := FcancelPessoaCommand.Parameters[1].Value.GetBoolean;
end;

function TControllerPessoaClient.Endereco(pIDPessoa: Int64; const ARequestFilter: string): TJSONObject;
begin
  if FEnderecoCommand = nil then
  begin
    FEnderecoCommand := FConnection.CreateCommand;
    FEnderecoCommand.RequestType := 'GET';
    FEnderecoCommand.Text := 'TControllerPessoa.Endereco';
    FEnderecoCommand.Prepare(TControllerPessoa_Endereco);
  end;
  FEnderecoCommand.Parameters[0].Value.SetInt64(pIDPessoa);
  FEnderecoCommand.Execute(ARequestFilter);
  Result := TJSONObject(FEnderecoCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TControllerPessoaClient.Endereco_Cache(pIDPessoa: Int64; const ARequestFilter: string): IDSRestCachedJSONObject;
begin
  if FEnderecoCommand_Cache = nil then
  begin
    FEnderecoCommand_Cache := FConnection.CreateCommand;
    FEnderecoCommand_Cache.RequestType := 'GET';
    FEnderecoCommand_Cache.Text := 'TControllerPessoa.Endereco';
    FEnderecoCommand_Cache.Prepare(TControllerPessoa_Endereco_Cache);
  end;
  FEnderecoCommand_Cache.Parameters[0].Value.SetInt64(pIDPessoa);
  FEnderecoCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONObject.Create(FEnderecoCommand_Cache.Parameters[1].Value.GetString);
end;

function TControllerPessoaClient.updateEndereco(pIDEndereco: Int64; obj: TJSONValue; const ARequestFilter: string): Boolean;
begin
  if FupdateEnderecoCommand = nil then
  begin
    FupdateEnderecoCommand := FConnection.CreateCommand;
    FupdateEnderecoCommand.RequestType := 'POST';
    FupdateEnderecoCommand.Text := 'TControllerPessoa."updateEndereco"';
    FupdateEnderecoCommand.Prepare(TControllerPessoa_updateEndereco);
  end;
  FupdateEnderecoCommand.Parameters[0].Value.SetInt64(pIDEndereco);
  FupdateEnderecoCommand.Parameters[1].Value.SetJSONValue(obj, FInstanceOwner);
  FupdateEnderecoCommand.Execute(ARequestFilter);
  Result := FupdateEnderecoCommand.Parameters[2].Value.GetBoolean;
end;

function TControllerPessoaClient.acceptEndereco(obj: TJSONValue; const ARequestFilter: string): Boolean;
begin
  if FacceptEnderecoCommand = nil then
  begin
    FacceptEnderecoCommand := FConnection.CreateCommand;
    FacceptEnderecoCommand.RequestType := 'POST';
    FacceptEnderecoCommand.Text := 'TControllerPessoa."acceptEndereco"';
    FacceptEnderecoCommand.Prepare(TControllerPessoa_acceptEndereco);
  end;
  FacceptEnderecoCommand.Parameters[0].Value.SetJSONValue(obj, FInstanceOwner);
  FacceptEnderecoCommand.Execute(ARequestFilter);
  Result := FacceptEnderecoCommand.Parameters[1].Value.GetBoolean;
end;

function TControllerPessoaClient.cancelEndereco(pIDEndereco: Int64; const ARequestFilter: string): Boolean;
begin
  if FcancelEnderecoCommand = nil then
  begin
    FcancelEnderecoCommand := FConnection.CreateCommand;
    FcancelEnderecoCommand.RequestType := 'GET';
    FcancelEnderecoCommand.Text := 'TControllerPessoa.cancelEndereco';
    FcancelEnderecoCommand.Prepare(TControllerPessoa_cancelEndereco);
  end;
  FcancelEnderecoCommand.Parameters[0].Value.SetInt64(pIDEndereco);
  FcancelEnderecoCommand.Execute(ARequestFilter);
  Result := FcancelEnderecoCommand.Parameters[1].Value.GetBoolean;
end;

function TControllerPessoaClient.EnderecoIntegracao(pIDEndereco: Int64; const ARequestFilter: string): TJSONObject;
begin
  if FEnderecoIntegracaoCommand = nil then
  begin
    FEnderecoIntegracaoCommand := FConnection.CreateCommand;
    FEnderecoIntegracaoCommand.RequestType := 'GET';
    FEnderecoIntegracaoCommand.Text := 'TControllerPessoa.EnderecoIntegracao';
    FEnderecoIntegracaoCommand.Prepare(TControllerPessoa_EnderecoIntegracao);
  end;
  FEnderecoIntegracaoCommand.Parameters[0].Value.SetInt64(pIDEndereco);
  FEnderecoIntegracaoCommand.Execute(ARequestFilter);
  Result := TJSONObject(FEnderecoIntegracaoCommand.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TControllerPessoaClient.EnderecoIntegracao_Cache(pIDEndereco: Int64; const ARequestFilter: string): IDSRestCachedJSONObject;
begin
  if FEnderecoIntegracaoCommand_Cache = nil then
  begin
    FEnderecoIntegracaoCommand_Cache := FConnection.CreateCommand;
    FEnderecoIntegracaoCommand_Cache.RequestType := 'GET';
    FEnderecoIntegracaoCommand_Cache.Text := 'TControllerPessoa.EnderecoIntegracao';
    FEnderecoIntegracaoCommand_Cache.Prepare(TControllerPessoa_EnderecoIntegracao_Cache);
  end;
  FEnderecoIntegracaoCommand_Cache.Parameters[0].Value.SetInt64(pIDEndereco);
  FEnderecoIntegracaoCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONObject.Create(FEnderecoIntegracaoCommand_Cache.Parameters[1].Value.GetString);
end;

function TControllerPessoaClient.AtualizaEnderecoIntegracao(const ARequestFilter: string = ''): Boolean;
begin
  if FupdateEnderecoIntegracaoCommand = nil then
  begin
    FupdateEnderecoIntegracaoCommand := FConnection.CreateCommand;
    FupdateEnderecoIntegracaoCommand.RequestType := 'GET';
    FupdateEnderecoIntegracaoCommand.Text := 'TControllerPessoa."AtualizaEnderecoIntegracao"';
    FupdateEnderecoIntegracaoCommand.Prepare(TControllerPessoa_AtualizaEnderecoIntegracao);
  end;
  FupdateEnderecoIntegracaoCommand.Execute(ARequestFilter);
  Result := FupdateEnderecoIntegracaoCommand.Parameters[0].Value.GetBoolean;
end;

function TControllerPessoaClient.acceptPessoas(obj: TJSONValue; const ARequestFilter: string): Boolean;
begin
  if FacceptPessoasCommand = nil then
  begin
    FacceptPessoasCommand := FConnection.CreateCommand;
    FacceptPessoasCommand.RequestType := 'POST';
    FacceptPessoasCommand.Text := 'TControllerPessoa."acceptPessoas"';
    FacceptPessoasCommand.Prepare(TControllerPessoa_acceptPessoas);
  end;
  FacceptPessoasCommand.Parameters[0].Value.SetJSONValue(obj, FInstanceOwner);
  FacceptPessoasCommand.Execute(ARequestFilter);
  Result := FacceptPessoasCommand.Parameters[1].Value.GetBoolean;
end;

procedure TControllerPessoaClient.AfterConstruction;
begin
  if FAfterConstructionCommand = nil then
  begin
    FAfterConstructionCommand := FConnection.CreateCommand;
    FAfterConstructionCommand.RequestType := 'GET';
    FAfterConstructionCommand.Text := 'TControllerPessoa.AfterConstruction';
  end;
  FAfterConstructionCommand.Execute;
end;

constructor TControllerPessoaClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TControllerPessoaClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TControllerPessoaClient.Destroy;
begin
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FPessoaCommand.DisposeOf;
  FPessoaCommand_Cache.DisposeOf;
  FupdatePessoaCommand.DisposeOf;
  FacceptPessoaCommand.DisposeOf;
  FcancelPessoaCommand.DisposeOf;
  FEnderecoCommand.DisposeOf;
  FEnderecoCommand_Cache.DisposeOf;
  FupdateEnderecoCommand.DisposeOf;
  FacceptEnderecoCommand.DisposeOf;
  FcancelEnderecoCommand.DisposeOf;
  FEnderecoIntegracaoCommand.DisposeOf;
  FEnderecoIntegracaoCommand_Cache.DisposeOf;
  FupdateEnderecoIntegracaoCommand.DisposeOf;
  FacceptPessoasCommand.DisposeOf;
  FAfterConstructionCommand.DisposeOf;
  inherited;
end;

end.
