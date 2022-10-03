unit uDMPessoa;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  REST.Types, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, FireDAC.Comp.BatchMove.JSON, FireDAC.Comp.BatchMove,
  FireDAC.Comp.BatchMove.Text, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI;

type
  TDMPessoa = class(TDataModule)
    Pessoa: TFDMemTable;
    Endereco: TFDMemTable;
    dsPessoa: TDataSource;
    Pessoas: TFDMemTable;
    FDBatchMove: TFDBatchMove;
    FDBatchMoveTextReader: TFDBatchMoveTextReader;
    FDBatchMoveJSONWriter: TFDBatchMoveJSONWriter;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    Integracao: TFDMemTable;
    dsEndereco: TDataSource;
    procedure EnderecoNewRecord(DataSet: TDataSet);
    procedure PessoaNewRecord(DataSet: TDataSet);
    procedure EnderecoBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    FAPIExec: Boolean;
    procedure FinishThread(Sender: TObject);
  public
    { Public declarations }
    procedure ConsultaPessoas(const pID: Largeint = 0);
    procedure ConsultaEnderecos(const pID: Largeint = 0);
    procedure ConsultaEnderecoIntegracao(const pID: Largeint = 0);
    procedure InsertPessoa;
    procedure InsertEndereco;

    procedure AplicaInsercaoPessoa;
    procedure AplicaEdicaoPessoa;
    procedure AplicaDelecaoPessoa;

    procedure AplicaInsercaoEndereco;
    procedure AplicaEdicaoEndereco;
    procedure AplicaDelecaoEndereco;

    procedure AplicaInsercaoMassa;
    procedure AtualizarCEP;
  end;

var
  DMPessoa: TDMPessoa;

implementation

uses
  uClientModule,
  Json,
  Rest.Json,
  uPessoa,
  StrUtils,
  uPessoaCad,
  uClientClasses;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDMPessoa }

procedure PrepareEnderecoIntegracao(pMemTable: TFDMemTable; pEnderecos: TListaEndereco_integracao = nil; pLimpar: boolean = False);
var
  i: integer;
begin
  pMemTable.DisableControls;
  try
    if pLimpar then
      pMemTable.Close;

    if pMemTable.FieldDefs.Count = 0 then
    begin
      pMemTable.FieldDefs.Add('idendereco', ftLargeint, 0, True);
      pMemTable.FieldDefs.Add('dsuf', TFieldType.ftString, 50);
      pMemTable.FieldDefs.Add('nmcidade', TFieldType.ftString, 100);
      pMemTable.FieldDefs.Add('nmbairro', TFieldType.ftString, 50);
      pMemTable.FieldDefs.Add('nmlogradouro', TFieldType.ftString, 100);
      pMemTable.FieldDefs.Add('dscomplemento', TFieldType.ftString, 100);
    end;

    if not pMemTable.Active then
      pMemTable.CreateDataSet;

    if Assigned(pEnderecos) then
      for I := 0 to pEnderecos.enderecosIntegracao.Count - 1 do
      begin
        pMemTable.Append;
        pMemTable.FieldByName('idendereco').AsLargeInt := pEnderecos.enderecosIntegracao.Items[i].idendereco;
        pMemTable.FieldByName('dsuf').AsString := pEnderecos.enderecosIntegracao.Items[i].dsuf;
        pMemTable.FieldByName('nmcidade').AsString := pEnderecos.enderecosIntegracao.Items[i].nmcidade;
        pMemTable.FieldByName('nmbairro').AsString := pEnderecos.enderecosIntegracao.Items[i].nmbairro;
        pMemTable.FieldByName('nmlogradouro').AsString := pEnderecos.enderecosIntegracao.Items[i].nmlogradouro;
        pMemTable.FieldByName('dscomplemento').AsString := pEnderecos.enderecosIntegracao.Items[i].dscomplemento;
        pMemTable.Post;
      end;
  finally
    pMemTable.EnableControls;
  end;
end;

procedure PrepareEndereco(pMemTable: TFDMemTable; pEnderecos: TListaEndereco = nil; pLimpar: boolean = False);
var
  i: integer;
begin
  pMemTable.DisableControls;
  try
    if pLimpar then
      pMemTable.Close;

    if pMemTable.FieldDefs.Count = 0 then
    begin
      pMemTable.FieldDefs.Add('idendereco', ftLargeint, 0, True);
      pMemTable.FieldDefs.Add('idpessoa', ftLargeint, 0, True);
      pMemTable.FieldDefs.Add('dscep', TFieldType.ftString, 15, True);
    end;

    if not pMemTable.Active then
      pMemTable.CreateDataSet;

    if Assigned(pEnderecos) then
      for I := 0 to pEnderecos.enderecos.Count - 1 do
      begin
        pMemTable.Append;
        pMemTable.FieldByName('idendereco').AsLargeInt := pEnderecos.enderecos.Items[i].idendereco;
        pMemTable.FieldByName('idpessoa').AsLargeInt := pEnderecos.enderecos.Items[i].idpessoa;
        pMemTable.FieldByName('dscep').AsString := pEnderecos.enderecos.Items[i].dscep;
        pMemTable.Post;
      end;
  finally
    pMemTable.EnableControls;
  end;
end;

procedure PreparePessoa(pMemTable: TFDMemTable; pPessoas: TListaPessoa = nil);
var
  i: integer;
begin
  pMemTable.DisableControls;
  try
    pMemTable.Close;
    if pMemTable.FieldDefs.Count = 0 then
    begin
      pMemTable.FieldDefs.Add('idpessoa', ftLargeint, 0, True);
      pMemTable.FieldDefs.Add('flnatureza', ftSmallint, 0, True);
      pMemTable.FieldDefs.Add('dsdocumento', TFieldType.ftString, 20, True);
      pMemTable.FieldDefs.Add('nmprimeiro', TFieldType.ftString, 100, True);
      pMemTable.FieldDefs.Add('nmsegundo', TFieldType.ftString, 100, True);
      pMemTable.FieldDefs.Add('dtregistro', TFieldType.ftDate);
    end;
    pMemTable.CreateDataSet;

    if Assigned(pPessoas) then
      for I := 0 to pPessoas.pessoas.Count - 1 do
      begin
        pMemTable.Append;
        pMemTable.FieldByName('idpessoa').AsLargeInt := pPessoas.pessoas.Items[i].idpessoa;
        pMemTable.FieldByName('flnatureza').AsLargeInt := pPessoas.pessoas.Items[i].flnatureza;
        pMemTable.FieldByName('dsdocumento').AsString := pPessoas.pessoas.Items[i].dsdocumento;
        pMemTable.FieldByName('nmprimeiro').AsString := pPessoas.pessoas.Items[i].nmprimeiro;
        pMemTable.FieldByName('nmsegundo').AsString := pPessoas.pessoas.Items[i].nmsegundo;
        pMemTable.FieldByName('dtregistro').AsDateTime := StrToDate(pPessoas.pessoas.Items[i].dtregistro);
        pMemTable.Post;
      end;
    pMemTable.First;
  finally
    pMemTable.EnableControls;
  end;
end;

procedure TDMPessoa.AplicaDelecaoEndereco;
begin
  if Pessoa.FieldByName('idpessoa').AsLargeInt > 0 then
    ClientModule.ControllerPessoaClient.cancelEndereco(Endereco.FieldByName('idendereco').AsLargeInt)
  else
    Endereco.Delete;
end;

procedure TDMPessoa.AplicaDelecaoPessoa;
begin
  ClientModule.ControllerPessoaClient.cancelPessoa(Pessoa.FieldByName('idpessoa').AsLargeInt);
end;

procedure TDMPessoa.AplicaEdicaoEndereco;
var
  vEndereco: TEndereco;
begin
  if Pessoa.FieldByName('idpessoa').AsLargeInt > 0 then
  begin
    vEndereco := TEndereco.Create;
    try
      vEndereco.idendereco := Endereco.FieldByName('idendereco').AsLargeInt;
      vEndereco.idpessoa := Endereco.FieldByName('idpessoa').AsLargeInt;
      vEndereco.dscep := Endereco.FieldByName('dscep').AsString;

      ClientModule.ControllerPessoaClient.updateEndereco(vEndereco.idendereco, TJson.ObjectToJsonObject(vEndereco));
    finally
      vEndereco.Free;
    end;
  end;
end;

procedure TDMPessoa.AplicaEdicaoPessoa;
var
  vPessoa: TPessoa;
begin
  vPessoa := TPessoa.Create;
  try
    vPessoa.idpessoa := Pessoa.FieldByName('idpessoa').AsLargeInt;
    vPessoa.flnatureza := Pessoa.FieldByName('flnatureza').AsLargeInt;
    vPessoa.dsdocumento := Pessoa.FieldByName('dsdocumento').AsString;
    vPessoa.nmprimeiro := Pessoa.FieldByName('nmprimeiro').AsString;
    vPessoa.nmsegundo := Pessoa.FieldByName('nmsegundo').AsString;
    vPessoa.dtregistro := DateToStr(Pessoa.FieldByName('dtregistro').AsDateTime);

    ClientModule.ControllerPessoaClient.updatePessoa(vPessoa.idpessoa, TJson.ObjectToJsonObject(vPessoa));
  finally
    vPessoa.Free;
  end;
end;

procedure TDMPessoa.AplicaInsercaoEndereco;
var
  vEndereco: TEndereco;
begin
  if Pessoa.FieldByName('idpessoa').AsLargeInt > 0 then
  begin
    vEndereco := TEndereco.Create;
    try
      vEndereco.idendereco := 0;
      vEndereco.idpessoa := Endereco.FieldByName('idpessoa').AsLargeInt;
      vEndereco.dscep := Endereco.FieldByName('dscep').AsString;

      ClientModule.ControllerPessoaClient.acceptEndereco(TJson.ObjectToJsonObject(vEndereco));
    finally
      vEndereco.Free;
    end;
  end;
end;

procedure TDMPessoa.AplicaInsercaoMassa;
var
  vFile: TStrings;
  vObjArray: TJSONArray;
  vPessoas: TListaPessoa;
  i: integer;
begin
  vFile := TStringList.Create;
  try
    vPessoas := TListaPessoa.Create;
    vFile.LoadFromFile(FDBatchMoveJSONWriter.FileName);
    vObjArray := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(vFile.Text), 0) as TJSONArray;

    for I := 0 to vObjArray.Count - 1 do
    begin
      vPessoas.pessoas.Add(TPessoa.Create);
      vPessoas.pessoas.Last.idpessoa := StrToInt(vObjArray.Items[i].P['idpessoa'].Value);
      vPessoas.pessoas.Last.flnatureza := StrToInt(vObjArray.Items[i].P['flnatureza'].Value);
      vPessoas.pessoas.Last.dsdocumento := vObjArray.Items[i].P['dsdocumento'].Value;
      vPessoas.pessoas.Last.nmprimeiro := vObjArray.Items[i].P['dsdocumento'].Value;
      vPessoas.pessoas.Last.nmsegundo := vObjArray.Items[i].P['dsdocumento'].Value;
      vPessoas.pessoas.Last.dtregistro := vObjArray.Items[i].P['dtregistro'].Value;
      vPessoas.pessoas.Last.endereco.dscep := vObjArray.Items[i].P['dscep'].Value;
    end;

    ClientModule.ControllerPessoaClient.acceptPessoas(TJson.ObjectToJsonObject(vPessoas))
  finally
    vFile.Free;
    vPessoas.Free;
  end;
end;

procedure TDMPessoa.AplicaInsercaoPessoa;
var
  vPessoa: TPessoa;
begin
  if Endereco.RecordCount > 0 then
  begin
    vPessoa := TPessoa.Create;
    try
      vPessoa.idpessoa := 0;
      vPessoa.flnatureza := Pessoa.FieldByName('flnatureza').AsLargeInt;
      vPessoa.dsdocumento := Pessoa.FieldByName('dsdocumento').AsString;
      vPessoa.nmprimeiro := Pessoa.FieldByName('nmprimeiro').AsString;
      vPessoa.nmsegundo := Pessoa.FieldByName('nmsegundo').AsString;
      vPessoa.dtregistro := DateToStr(Pessoa.FieldByName('dtregistro').AsDateTime);

      vPessoa.endereco.idendereco := Endereco.FieldByName('idendereco').AsLargeInt;
      vPessoa.endereco.idpessoa := Endereco.FieldByName('idpessoa').AsLargeInt;
      vPessoa.endereco.dscep := Endereco.FieldByName('dscep').AsString;

      ClientModule.ControllerPessoaClient.acceptPessoa(TJson.ObjectToJsonObject(vPessoa));
    finally
      vPessoa.Free;
    end;
  end
  else
    raise Exception.CreateHelp('Não é possível inserir pessoa sem o cep!', 0);
end;

procedure TDMPessoa.AtualizarCEP;
begin
  FAPIExec := False;

  PessoaCad.MemoAPI.Visible := True;
  PessoaCad.MemoAPI.Lines.Text := 'Processamento da API CEP em andamento...';

  with TThread.CreateAnonymousThread(
    procedure
    var
      vC: TClientModule;
    begin
      vC := TClientModule.Create(nil);
      try
        vC.ControllerPessoaClient.AtualizaEnderecoIntegracao;
        FAPIExec := True;
      finally
        vC.Free;
      end;
    end) do
  begin
    OnTerminate := FinishThread;
    Start;
  end;
end;

procedure TDMPessoa.ConsultaEnderecoIntegracao(const pID: Largeint);
var
  vEnredecos: TListaEndereco_integracao;
begin
  vEnredecos := TJson.JsonToObject<TListaEndereco_integracao>(ClientModule.ControllerPessoaClient.EnderecoIntegracao(pID).ToString);
  try
    PrepareEnderecoIntegracao(Integracao, vEnredecos, True);
  finally
    vEnredecos.Free;
  end;
end;

procedure TDMPessoa.ConsultaEnderecos(const pID: Largeint);
var
  vEnredecos: TListaEndereco;
begin
  vEnredecos := TJson.JsonToObject<TListaEndereco>(ClientModule.ControllerPessoaClient.Endereco(pID).ToString);
  try
    PrepareEndereco(Endereco, vEnredecos, True);
    ConsultaEnderecoIntegracao(pID);
  finally
    vEnredecos.Free;
  end;
end;

procedure TDMPessoa.ConsultaPessoas(const pID: Largeint = 0);
var
  vPessoas: TListaPessoa;
  vID: Largeint;
begin
  if Pessoas.Active then
    vID := Pessoas.FieldByName('idpessoa').AsLargeInt;

  vPessoas := TJson.JsonToObject<TListaPessoa>(ClientModule.ControllerPessoaClient.Pessoa(pID).ToString);
  try
    if pID = 0 then
      PreparePessoa(Pessoas, vPessoas)
    else
    begin
      PreparePessoa(Pessoa, vPessoas);
      ConsultaEnderecos(pID);
    end;
  finally
    vPessoas.Free;
    Pessoas.Locate('idpessoa', vID, []);
  end;
end;

procedure TDMPessoa.EnderecoBeforePost(DataSet: TDataSet);
begin
  if (DataSet.FieldByName('dscep').AsString.Length <> 8) then
    raise Exception.Create('CEP Válido precisa ter 8 dígitos! Verifique.');
end;

procedure TDMPessoa.EnderecoNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('idendereco').AsLargeInt := (DataSet.RecordCount * -1) - 1;
end;

procedure TDMPessoa.FinishThread(Sender: TObject);
begin
  FAPIExec := False;

  if Assigned(TThread(Sender).FatalException) then
    PessoaCad.MemoAPI.Lines.Text := Exception(TThread(Sender).FatalException).Message
  else
    PessoaCad.MemoAPI.Lines.Text := 'Processamento da API CEP Finalizada com sucesso!';
end;

procedure TDMPessoa.InsertEndereco;
begin
  PrepareEndereco(Endereco, nil);
  Endereco.Append;
end;

procedure TDMPessoa.InsertPessoa;
begin
  PreparePessoa(Pessoa);
  Pessoa.Append;
end;

procedure TDMPessoa.PessoaNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('idpessoa').AsLargeInt := (DataSet.RecordCount * -1) - 1;
  DataSet.FieldByName('dtregistro').AsDateTime := Date;
end;

end.



