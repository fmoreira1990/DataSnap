unit uControllerPessoa;

interface

uses System.SysUtils, System.Classes, System.Json,
  DataSnap.DSProviderDataModuleAdapter,
  Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.PGDef, FireDAC.Phys.PG, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, REST.Types, REST.Response.Adapter, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.UI.Intf,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script;

type
  TControllerPessoa = class(TDSServerModule)
    FDPessoa: TFDQuery;
    FDConnection1: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    FDEndereco: TFDQuery;
    FDSequence: TFDQuery;
    FDIntegracao: TFDQuery;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDCEP: TFDMemTable;
    FDScript: TFDScript;
    FDCEPs: TFDMemTable;
    FDDados: TFDMemTable;
  private
    { Private declarations }
    procedure DoTratarExeption(const pException: string);
    function GetSequence(const pName: string): Int64;
  public
    { Public declarations }

    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;

    //pessoas
    function Pessoa(pIDPessoa: Int64): TJSONObject; // GET
    function updatePessoa(pIDPessoa: Int64; obj: TJSONValue): Boolean; // POST
    function acceptPessoa(obj: TJSONValue): Boolean; // PUT
    function cancelPessoa(pIDPessoa: Int64): Boolean; // DELETE

    //endereco
    function Endereco(pIDPessoa: Int64): TJSONObject; // GET
    function updateEndereco(pIDEndereco: Int64; obj: TJSONValue): Boolean; // POST
    function acceptEndereco(obj: TJSONValue): Boolean; // PUT
    function cancelEndereco(pIDEndereco: Int64): Boolean; // DELETE

    //integracao
    function EnderecoIntegracao(pIDPessoa: Int64): TJSONObject; // GET
    function AtualizaEnderecoIntegracao: Boolean; // GET

    //inserção em massa de pessoas
    function acceptPessoas(obj: TJSONValue): Boolean; // POST

    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}

uses System.StrUtils,
  Data.DBXPlatform,
  REST.Json,
  uPessoa;

function TControllerPessoa.acceptEndereco(obj: TJSONValue): Boolean;
var
  vEndereco: TEndereco;
begin
  Result := False;
  try
    vEndereco := TJson.JsonToObject<TEndereco>(obj.tostring);
    try
      FDConnection1.StartTransaction;
      FDEndereco.Close;
      FDEndereco.SQL.Text :=
        ' INSERT INTO public.endereco(' +
        ' idpessoa, dscep)' +
        ' VALUES (:idpessoa, :dscep)';

      FDEndereco.ParamByName('idpessoa').AsLargeInt := vEndereco.idpessoa;
      FDEndereco.ParamByName('dscep').AsString := vEndereco.dscep;
      FDEndereco.ExecSQL;

      Result := FDEndereco.RowsAffected = 1;

    finally
      vEndereco.Free;
    end;

    if not Result then
      FDConnection1.Rollback
    else
      FDConnection1.Commit;

  except on E: Exception do
    begin
      DoTratarExeption(E.Message); // Msg Original
      FDConnection1.Rollback;
    end;
  end;
end;

function TControllerPessoa.acceptPessoa(obj: TJSONValue): Boolean;
var
  vPessoa: TPessoa;
begin
  Result := False;
  try
    vPessoa := TJson.JsonToObject<TPessoa>(obj.tostring);
    try
      FDConnection1.StartTransaction;
      FDPessoa.SQL.Text :=
        ' INSERT INTO public.pessoa(' +
        ' idpessoa, flnatureza, dsdocumento, nmprimeiro, nmsegundo, dtregistro)' +
        ' VALUES (:idpessoa, :flnatureza, :dsdocumento, :nmprimeiro, :nmsegundo, :dtregistro)';

      vPessoa.idpessoa := GetSequence('pessoa_idpessoa_seq');
      FDPessoa.ParamByName('idpessoa').AsLargeInt := vPessoa.idpessoa;
      FDPessoa.ParamByName('flnatureza').AsSmallInt := vPessoa.flnatureza;
      FDPessoa.ParamByName('dsdocumento').AsString := vPessoa.dsdocumento;
      FDPessoa.ParamByName('nmprimeiro').AsString := vPessoa.nmprimeiro;
      FDPessoa.ParamByName('nmsegundo').AsString := vPessoa.nmsegundo;
      FDPessoa.ParamByName('dtregistro').AsDate := StrToDate(vPessoa.dtregistro);
      FDPessoa.ExecSQL;

      if FDPessoa.RowsAffected = 1 then
      begin
        FDEndereco.Close;
        FDEndereco.SQL.Text :=
          ' INSERT INTO public.endereco(' +
          ' idendereco, idpessoa, dscep)' +
          ' VALUES (:idendereco, :idpessoa, :dscep)';

        vPessoa.endereco.idendereco := GetSequence('endereco_idendereco_seq');
        FDEndereco.ParamByName('idendereco').AsLargeInt := vPessoa.endereco.idendereco;
        FDEndereco.ParamByName('idpessoa').AsLargeInt := vPessoa.idpessoa;
        FDEndereco.ParamByName('dscep').AsString := vPessoa.endereco.dscep;
        FDEndereco.ExecSQL;

        Result := FDPessoa.RowsAffected > 0;
      end;
    finally
      vPessoa.Free;
    end;

    if not Result then
      FDConnection1.Rollback
    else
      FDConnection1.Commit;

  except on E: Exception do
    begin
      DoTratarExeption(E.Message); // Msg Original
      FDConnection1.Rollback;
    end;
  end;
end;

procedure TControllerPessoa.AfterConstruction;
begin
  inherited;
  FDPhysPgDriverLink1.VendorLib := GetCurrentDir + '\PostgreSQL32\libpq.dll';
end;

function TControllerPessoa.cancelEndereco(pIDEndereco: Int64): Boolean;
begin
  Result := False;
  try
    FDConnection1.StartTransaction;
    FDEndereco.SQL.Text :=
      ' select coalesce(count(idendereco),0) as qtde ' +
      ' from endereco ' +
      ' where idpessoa =  ' +
      ' (select idpessoa from endereco ' +
      ' WHERE idendereco= :idendereco)';

    FDEndereco.ParamByName('idendereco').AsLargeInt := pIDEndereco;
    FDEndereco.Open;
    if FDEndereco.FieldByName('qtde').AsInteger < 2 then
      raise Exception.Create('Não é possível excluir o único endereço da pessoa!');

    FDEndereco.SQL.Text :=
      ' delete from endereco ' +
      ' WHERE idendereco= :idendereco';

    FDEndereco.ParamByName('idendereco').AsLargeInt := pIDEndereco;
    FDEndereco.ExecSQL;

    Result := FDEndereco.RowsAffected = 1;

    if not Result then
      FDConnection1.Rollback
    else
      FDConnection1.Commit;

  except on E: Exception do
    begin
      DoTratarExeption(E.Message); // Msg Original
      FDConnection1.Rollback;
    end;
  end;
end;

function TControllerPessoa.cancelPessoa(pIDPessoa: Int64): Boolean;
begin
  Result := False;
  try
    FDConnection1.StartTransaction;
    FDPessoa.SQL.Text :=
      ' delete from pessoa ' +
      ' WHERE idpessoa= :idpessoa';

    FDPessoa.ParamByName('idpessoa').AsLargeInt := pIDPessoa;
    FDPessoa.ExecSQL;

    Result := FDPessoa.RowsAffected = 1;

    if not Result then
      FDConnection1.Rollback
    else
      FDConnection1.Commit;

  except on E: Exception do
    begin
      DoTratarExeption(E.Message); // Msg Original
      FDConnection1.Rollback;
    end;
  end;
end;

procedure TControllerPessoa.DoTratarExeption(const pException: string);
begin
  GetInvocationMetadata.ResponseMessage := pException;
  raise Exception.Create(pException);
end;

function TControllerPessoa.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TControllerPessoa.Endereco(pIDPessoa: Int64): TJSONObject;
var
  vEndereco: TListaEndereco;
begin
  try
    vEndereco := TListaEndereco.Create;
    try
      FDEndereco.SQL.Text := 'select * from endereco ';
      if pIDPessoa > 0 then
      begin
        FDEndereco.SQL.Text := FDEndereco.SQL.Text + ' where idpessoa = :idpessoa';
        FDEndereco.ParamByName('idpessoa').AsLargeInt := pIDPessoa;
      end;

      FDEndereco.Open;
      FDEndereco.First;
      while not FDEndereco.Eof do
      begin
        vEndereco.enderecos.Add(TEndereco.Create);
        vEndereco.enderecos.Last.idpessoa := FDEndereco.FieldByName('idpessoa').Value;
        vEndereco.enderecos.Last.idendereco := FDEndereco.FieldByName('idendereco').Value;
        vEndereco.enderecos.Last.dscep := FDEndereco.FieldByName('dscep').Value;

        FDEndereco.Next;
      end;

      Result := tjson.ObjectToJsonObject(vEndereco);
    finally
      vEndereco.Free;
    end;

  except on E: Exception do
    begin
      DoTratarExeption(E.Message); // Msg Original
    end;
  end;
end;

function TControllerPessoa.EnderecoIntegracao(pIDPessoa: Int64): TJSONObject;
var
  vEnderecos: TListaEndereco_integracao;
begin
  try
    vEnderecos := TListaEndereco_integracao.Create;
    try
      FDIntegracao.SQL.Text :=
        ' select * from endereco_integracao i ' +
        ' inner join endereco e on e.idendereco = i.idendereco ';
      if pIDPessoa > 0 then
      begin
        FDIntegracao.SQL.Text := FDIntegracao.SQL.Text + ' where e.idpessoa = :idpessoa';
        FDIntegracao.ParamByName('idpessoa').AsLargeInt := pIDPessoa;
      end;

      FDIntegracao.Open;
      FDIntegracao.First;
      while not FDIntegracao.Eof do
      begin
        vEnderecos.enderecosIntegracao.Add(TEndereco_integracao.Create);
        vEnderecos.enderecosIntegracao.Last.idendereco := FDIntegracao.FieldByName('idendereco').Value;
        vEnderecos.enderecosIntegracao.Last.dsuf := FDIntegracao.FieldByName('dsuf').Value;
        vEnderecos.enderecosIntegracao.Last.nmcidade := FDIntegracao.FieldByName('nmcidade').Value;
        vEnderecos.enderecosIntegracao.Last.nmbairro := FDIntegracao.FieldByName('nmbairro').Value;
        vEnderecos.enderecosIntegracao.Last.nmlogradouro := FDIntegracao.FieldByName('nmlogradouro').Value;
        vEnderecos.enderecosIntegracao.Last.dscomplemento := FDIntegracao.FieldByName('dscomplemento').Value;

        FDIntegracao.Next;
      end;

      Result := tjson.ObjectToJsonObject(vEnderecos);
    finally
      vEnderecos.Free;
    end;

  except on E: Exception do
    begin
      DoTratarExeption(E.Message); // Msg Original
    end;
  end;
end;

function TControllerPessoa.GetSequence(const pName: string): Int64;
begin
  FDSequence.Close;
  FDSequence.Params[0].AsString := pName;
  FDSequence.Open;
  Result := FDSequence.FieldByName('id').AsLargeInt;
end;

function TControllerPessoa.Pessoa(pIDPessoa: Int64): TJSONObject;
var
  vPessoas: TListaPessoa;
begin
  try
    vPessoas := TListaPessoa.Create;
    try
      FDPessoa.SQL.Text := 'select * from pessoa ';
      if pIDPessoa > 0 then
      begin
        FDPessoa.SQL.Text := FDPessoa.SQL.Text + ' where idpessoa = :idpessoa';
        FDPessoa.ParamByName('idpessoa').AsLargeInt := pIDPessoa;
      end;

      FDPessoa.Open;
      FDPessoa.First;
      while not FDPessoa.Eof do
      begin
        vPessoas.pessoas.Add(TPessoa.Create);
        vPessoas.pessoas.Last.idpessoa := FDPessoa.FieldByName('idpessoa').Value;
        vPessoas.pessoas.Last.flnatureza := FDPessoa.FieldByName('flnatureza').Value;
        vPessoas.pessoas.Last.dsdocumento := FDPessoa.FieldByName('dsdocumento').Value;
        vPessoas.pessoas.Last.nmprimeiro := FDPessoa.FieldByName('nmprimeiro').Value;
        vPessoas.pessoas.Last.nmsegundo := FDPessoa.FieldByName('nmsegundo').Value;
        vPessoas.pessoas.Last.dtregistro := FDPessoa.FieldByName('dtregistro').Value;

        FDPessoa.Next;
      end;

      Result := tjson.ObjectToJsonObject(vPessoas);
    finally
      vPessoas.Free;
    end;

  except on E: Exception do
    begin
      DoTratarExeption(E.Message); // Msg Original
    end;
  end;
end;

function TControllerPessoa.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

function TControllerPessoa.updateEndereco(pIDEndereco: Int64; obj: TJSONValue): Boolean;
var
  vEndereco: TEndereco;
begin
  Result := False;
  try
    vEndereco := TJson.JsonToObject<TEndereco>(obj.tostring);
    try
      FDConnection1.StartTransaction;
      FDEndereco.SQL.Text :=
        ' UPDATE public.endereco ' +
        ' SET dscep=:dscep ' +
        ' WHERE idendereco= :idendereco';

      FDEndereco.ParamByName('dscep').AsString := vEndereco.dscep;
      FDEndereco.ParamByName('idendereco').AsLargeInt := vEndereco.idendereco;
      FDEndereco.ExecSQL;

      Result := FDEndereco.RowsAffected = 1;

      if not Result then
        FDConnection1.Rollback
      else
        FDConnection1.Commit;

    finally
      vEndereco.Free;
    end;

  except on E: Exception do
    begin
      DoTratarExeption(E.Message); // Msg Original
      FDConnection1.Rollback;
    end;
  end;
end;

function TControllerPessoa.AtualizaEnderecoIntegracao: Boolean;
var
  vEnderecos: TListaEndereco_integracao;
  I: integer;
begin
  Result := False;
  try
    vEnderecos := TListaEndereco_integracao.Create;
    try
      FDConnection1.StartTransaction;
      FDEndereco.SQL.Text := 'select dscep from endereco group by dscep';
      FDEndereco.Open;
      FDCEPs.Data := FDEndereco.Data;

      FDCEPs.First;
      while not FDCEPs.Eof do
      begin
        try
          RESTClient1.BaseURL := 'http://viacep.com.br/ws/' + FDCEPs.FieldByName('dscep').AsString + '/json';
          RESTRequest1.Execute;

          if FDDados.Fields.Count = 0 then
          begin
            FDDados.FieldDefs := FDCEP.FieldDefs;
            FDDados.CreateDataSet;
          end;

          if Assigned(FDCEP.FindField('uf')) then
          begin
            FDDados.Append;
            FDDados.CopyRecord(FDCEP);
            FDDados.FieldByName('cep').AsString := ReplaceStr(FDDados.FieldByName('cep').AsString, '-', '');
            FDDados.Post;
          end;

        except on E: Exception do
          begin
            if Pos('TEMPO LIMITE', UpperCase(E.Message)) > 0 then
              raise Exception.Create('API viacep fora do ar!')
          end;
        end;

        FDCEPs.Next;
      end;

      FDEndereco.SQL.Text := 'select * from endereco order by idpessoa';
      FDEndereco.Open;
      FDEndereco.First;
      while not FDEndereco.Eof do
      begin
        if FDDados.Locate('cep', FDEndereco.FieldByName('dscep').AsString, []) then
        begin
          vEnderecos.enderecosIntegracao.Add(TEndereco_integracao.Create);
          vEnderecos.enderecosIntegracao.Last.idendereco := FDEndereco.FieldByName('idendereco').Value;
          vEnderecos.enderecosIntegracao.Last.dsuf := FDDados.FieldByName('uf').Value;
          vEnderecos.enderecosIntegracao.Last.nmcidade := FDDados.FieldByName('localidade').Value;
          vEnderecos.enderecosIntegracao.Last.nmbairro := FDDados.FieldByName('bairro').Value;
          vEnderecos.enderecosIntegracao.Last.nmlogradouro := FDDados.FieldByName('logradouro').Value;
          vEnderecos.enderecosIntegracao.Last.dscomplemento := FDDados.FieldByName('complemento').Value;

          FDEndereco.Next;
        end;
      end;

      FDIntegracao.SQL.Text :=
        ' DROP FUNCTION IF EXISTS pg_temp._func_endereco_integracao(pidendereco bigint, pdsuf varchar(50), pnmcidade varchar(100), pnmbairro varchar(50), pnmlogradouro varchar(100), pdscomplemento varchar(100));   ' +
        ' CREATE OR REPLACE FUNCTION pg_temp._func_endereco_integracao(pidendereco bigint, pdsuf varchar(50), pnmcidade varchar(100), pnmbairro varchar(50), pnmlogradouro varchar(100), pdscomplemento varchar(100)) returns void as $$  ' +
        ' BEGIN                                             ' +

      '  IF EXISTS(SELECT idendereco                        ' +
        '          FROM   endereco_integracao               ' +
        '         WHERE  idendereco = pidendereco)          ' +

      ' THEN                                                 ' +
        '  UPDATE endereco_integracao SET                    ' +
        '       dsuf      		= pdsuf,                       ' +
        '       nmcidade         = pnmcidade,                ' +
        '       nmbairro         = pnmbairro,                ' +
        '       nmlogradouro     = pnmlogradouro,            ' +
        '       dscomplemento   	= pdscomplemento           ' +
        ' WHERE idendereco 		= pidendereco;                 ' +

      '  ELSE                                                ' +
        'INSERT INTO endereco_integracao                     ' +
        '      (idendereco,                                  ' +
        '			dsuf,                                          ' +
        '            nmcidade,                               ' +
        '            nmbairro,                               ' +
        '            nmlogradouro,                           ' +
        '            dscomplemento)                          ' +
        '     VALUES                                         ' +
        '           (pidendereco,                            ' +
        '			pdsuf,                                         ' +
        '            pnmcidade,                              ' +
        '            pnmbairro,                              ' +
        '            pnmlogradouro,                          ' +
        '            pdscomplemento);                        ' +
        '                                                    ' +
        '   END IF;                                          ' +
        ' END;                                               ' +
        ' $$ LANGUAGE plpgsql;                               ' +

      ' select pg_temp._func_endereco_integracao(:idendereco ::bigint, :dsuf ::varchar(50), :nmcidade ::varchar(100), :nmbairro ::varchar(50), :nmlogradouro ::varchar(100), :dscomplemento ::varchar(100)); ';

      FDScript.Connection := FDConnection1;
      FDScript.SQLScripts.Add;
      for i := 0 to vEnderecos.enderecosIntegracao.Count - 1 do
      begin
        FDIntegracao.ParamByName('idendereco').AsLargeInt := vEnderecos.enderecosIntegracao[i].idendereco;

        FDIntegracao.ParamByName('dsuf').AsString := vEnderecos.enderecosIntegracao[i].dsuf.ToUpper;
        FDIntegracao.ParamByName('dsuf').Size := 50;

        FDIntegracao.ParamByName('nmcidade').AsString := vEnderecos.enderecosIntegracao[i].nmcidade.ToUpper;
        FDIntegracao.ParamByName('nmcidade').Size := 100;

        FDIntegracao.ParamByName('nmbairro').AsString := vEnderecos.enderecosIntegracao[i].nmbairro.ToUpper;
        FDIntegracao.ParamByName('nmbairro').Size := 50;

        FDIntegracao.ParamByName('nmlogradouro').AsString := vEnderecos.enderecosIntegracao[i].nmlogradouro.ToUpper;
        FDIntegracao.ParamByName('nmlogradouro').Size := 100;

        FDIntegracao.ParamByName('dscomplemento').AsString := vEnderecos.enderecosIntegracao[i].dscomplemento.ToUpper;
        FDIntegracao.ParamByName('dscomplemento').Size := 100;

        FDScript.SQLScripts[0].SQL.Text := Trim(FDIntegracao.SQL.Text);
        FDScript.Params := FDIntegracao.Params;

        FDScript.ValidateAll;
        FDScript.ExecuteAll;
      end;

      FDConnection1.Commit;
      Result := True;
    finally
      vEnderecos.Free;
    end;

  except on E: Exception do
    begin
      DoTratarExeption(E.Message); // Msg Original
      FDConnection1.Rollback;
    end;
  end;
end;

function TControllerPessoa.updatePessoa(pIDPessoa: Int64; obj: TJSONValue): Boolean;
var
  vPessoa: TPessoa;
begin
  Result := False;
  try
    vPessoa := TJson.JsonToObject<TPessoa>(obj.tostring);
    try
      FDConnection1.StartTransaction;
      FDPessoa.SQL.Text :=
        ' UPDATE public.pessoa ' +
        ' SET flnatureza=:flnatureza, dsdocumento=:dsdocumento, nmprimeiro=:nmprimeiro, nmsegundo=:nmsegundo, dtregistro=:dtregistro ' +
        ' WHERE idpessoa= :idpessoa';

      FDPessoa.ParamByName('flnatureza').AsSmallInt := vPessoa.flnatureza;
      FDPessoa.ParamByName('dsdocumento').AsString := vPessoa.dsdocumento;
      FDPessoa.ParamByName('nmprimeiro').AsString := vPessoa.nmprimeiro;
      FDPessoa.ParamByName('nmsegundo').AsString := vPessoa.nmsegundo;
      FDPessoa.ParamByName('dtregistro').AsDate := StrToDate(vPessoa.dtregistro);
      FDPessoa.ParamByName('idpessoa').AsLargeInt := vPessoa.idpessoa;
      FDPessoa.ExecSQL;

      Result := FDPessoa.RowsAffected = 1;

      if not Result then
        FDConnection1.Rollback
      else
        FDConnection1.Commit;

    finally
      vPessoa.Free;
    end;

  except on E: Exception do
    begin
      DoTratarExeption(E.Message); // Msg Original
      FDConnection1.Rollback;
    end;
  end;
end;

function TControllerPessoa.acceptPessoas(obj: TJSONValue): Boolean;
var
  vListaPessoa: TListaPessoa;
  i: integer;
begin
  Result := False;
  try
    vListaPessoa := TJson.JsonToObject<TListaPessoa>(obj.ToString);
    try
      FDConnection1.StartTransaction;
      FDPessoa.SQL.Text :=
        ' INSERT INTO public.pessoa(' +
        ' idpessoa, flnatureza, dsdocumento, nmprimeiro, nmsegundo, dtregistro)' +
        ' VALUES (:idpessoa, :flnatureza, :dsdocumento, :nmprimeiro, :nmsegundo, :dtregistro)';

      FDEndereco.SQL.Text :=
        ' INSERT INTO public.endereco(' +
        ' idendereco, idpessoa, dscep)' +
        ' VALUES (:idendereco, :idpessoa, :dscep)';

      FDPessoa.Params.ArraySize := 0;
      FDEndereco.Params.ArraySize := 0;

      for i := 0 to vListaPessoa.pessoas.Count - 1 do
      begin
        FDPessoa.Params.ArraySize := FDPessoa.Params.ArraySize + 1;
        vListaPessoa.pessoas[i].idpessoa := GetSequence('pessoa_idpessoa_seq');

        FDPessoa.ParamByName('idpessoa').AsLargeInts[FDPessoa.Params.ArraySize - 1] := vListaPessoa.pessoas[i].idpessoa;
        FDPessoa.ParamByName('flnatureza').AsSmallInts[FDPessoa.Params.ArraySize - 1] := vListaPessoa.pessoas[i].flnatureza;

        FDPessoa.ParamByName('dsdocumento').AsStrings[FDPessoa.Params.ArraySize - 1] := vListaPessoa.pessoas[i].dsdocumento;
        FDPessoa.ParamByName('dsdocumento').Size := 20;

        FDPessoa.ParamByName('nmprimeiro').AsStrings[FDPessoa.Params.ArraySize - 1] := vListaPessoa.pessoas[i].nmprimeiro;
        FDPessoa.ParamByName('nmprimeiro').Size := 100;

        FDPessoa.ParamByName('nmsegundo').AsStrings[FDPessoa.Params.ArraySize - 1] := vListaPessoa.pessoas[i].nmsegundo;
        FDPessoa.ParamByName('nmsegundo').Size := 100;

        FDPessoa.ParamByName('dtregistro').AsDates[FDPessoa.Params.ArraySize - 1] := StrToDate(vListaPessoa.pessoas[i].dtregistro);

        FDEndereco.Params.ArraySize := FDEndereco.Params.ArraySize + 1;
        vListaPessoa.pessoas[i].endereco.idendereco := GetSequence('endereco_idendereco_seq');

        FDEndereco.ParamByName('idendereco').AsLargeInts[FDEndereco.Params.ArraySize - 1] := vListaPessoa.pessoas[i].endereco.idendereco;
        FDEndereco.ParamByName('idpessoa').AsLargeInts[FDEndereco.Params.ArraySize - 1] := vListaPessoa.pessoas[i].idpessoa;

        FDEndereco.ParamByName('dscep').AsStrings[FDEndereco.Params.ArraySize - 1] := vListaPessoa.pessoas[i].endereco.dscep;
        FDEndereco.ParamByName('dscep').Size := 15;
      end;

      FDPessoa.Prepare;
      FDPessoa.Execute(FDPessoa.Params.ArraySize, 0);

      FDEndereco.Prepare;
      FDEndereco.Execute(FDEndereco.Params.ArraySize, 0);

      Result := True;
    finally
      vListaPessoa.Free;
    end;

    if not Result then
      FDConnection1.Rollback
    else
      FDConnection1.Commit;

  except on E: Exception do
    begin
      DoTratarExeption(E.Message); // Msg Original
      FDConnection1.Rollback;
    end;
  end;
end;

end.



