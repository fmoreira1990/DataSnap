unit uPessoaCadM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Data.DB, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, uPessoa;

type
  TPessoaCadM = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    dsPessoa: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Label3: TLabel;
    DBEdit4: TDBEdit;
    Label4: TLabel;
    DBEdit5: TDBEdit;
    Label5: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    dsEndereco: TDataSource;
    Label6: TLabel;
    Label7: TLabel;
    Panel4: TPanel;
    DBGrid2: TDBGrid;
    dsIntegracao: TDataSource;
    btnSave: TButton;
    btnCancel: TButton;
    btnInsert: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    FAcao: TAcao;
  protected
    procedure DoShow; override;

    procedure DoStateButtons;

    { Private declarations }
  public
    { Public declarations }
    property Acao: TAcao read FAcao write FAcao;

  end;

var
  PessoaCadM: TPessoaCadM;

implementation

uses
  uDmPessoa,
  uPessoaCadD;

{$R *.dfm}

procedure TPessoaCadM.btnCancelClick(Sender: TObject);
begin
  if DMPessoa.Pessoa.State in dsEditModes then
    DMPessoa.Pessoa.Cancel;

  DMPessoa.Pessoa.Close;
  DMPessoa.Endereco.Close;

  ModalResult := mrCancel;
end;

procedure TPessoaCadM.btnDeleteClick(Sender: TObject);
begin
  PessoaCadD.Acao := TDelete;
  if PessoaCadD.ShowModal = mrOk then
  begin
    DoStateButtons;

    if btnInsert.Enabled then
      DMPessoa.ConsultaEnderecos(DMPessoa.Pessoa.FieldByName('idpessoa').AsLargeInt);
  end;
end;

procedure TPessoaCadM.btnEditClick(Sender: TObject);
begin
  PessoaCadD.Acao := tEdit;
  if PessoaCadD.ShowModal = mrOk then
  begin
    DoStateButtons;

    if btnInsert.Enabled then
      DMPessoa.ConsultaEnderecos(DMPessoa.Pessoa.FieldByName('idpessoa').AsLargeInt);
  end;
end;

procedure TPessoaCadM.DoStateButtons;
begin
  if DMPessoa.Pessoa.Active and DMPessoa.Endereco.Active then
  begin
    if (DMPessoa.Pessoa.FieldByName('idpessoa').AsLargeInt <= 0) and (DMPessoa.Endereco.RecordCount = 1) then
      btnInsert.Enabled := False
    else
      btnInsert.Enabled := True;
  end;

  if DMPessoa.Endereco.Active then
  begin
    btnEdit.Enabled := DMPessoa.Endereco.RecordCount > 0;
    btnDelete.Enabled := DMPessoa.Endereco.RecordCount > 0;
  end
  else
  begin
    btnEdit.Enabled := false;
    btnDelete.Enabled := false;
  end;
end;

procedure TPessoaCadM.btnInsertClick(Sender: TObject);
begin
  DMPessoa.InsertEndereco;
  PessoaCadD.Acao := tInsert;
  if PessoaCadD.ShowModal = mrOk then
  begin
    DoStateButtons;

    if btnInsert.Enabled then
      DMPessoa.ConsultaEnderecos(DMPessoa.Pessoa.FieldByName('idpessoa').AsLargeInt);
  end;
end;

procedure TPessoaCadM.btnSaveClick(Sender: TObject);
begin
  if DMPessoa.Pessoa.State in dsEditModes then
    DMPessoa.Pessoa.Post;

  case Acao of
    tInsert: DMPessoa.AplicaInsercaoPessoa;
    tEdit: DMPessoa.AplicaEdicaoPessoa;
    TDelete: DMPessoa.AplicaDelecaoPessoa;
  end;

  DMPessoa.Pessoa.Close;
  DMPessoa.Endereco.Close;

  ModalResult := mrOk;
end;

procedure TPessoaCadM.DoShow;
begin
  inherited;
  case FAcao of
    tInsert, tEdit: btnSave.Caption := 'Save';
    TDelete: btnSave.Caption := 'Delete';
  end;
  Label7.Caption := dsPessoa.DataSet.FieldByName('idpessoa').AsString;
  DoStateButtons;
  if DBEdit1.CanFocus then
    DBEdit1.SetFocus;
end;

end.



