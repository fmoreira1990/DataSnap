unit uPessoaCadD;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Data.DB, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Vcl.ExtCtrls, uPessoa, Vcl.Grids, Vcl.DBGrids;

type
  TPessoaCadD = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    dEndereco: TDataSource;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    dsIntegracao: TDataSource;
    btnSave: TButton;
    btnCancel: TButton;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure DBEdit1KeyPress(Sender: TObject; var Key: Char);
  private
    FAcao: TAcao;
  protected
    procedure DoShow; override;
    { Private declarations }
  public
    { Public declarations }
    property Acao: TAcao read FAcao write FAcao;

  end;

var
  PessoaCadD: TPessoaCadD;

implementation

uses
  uDMPessoa;

{$R *.dfm}

procedure TPessoaCadD.btnCancelClick(Sender: TObject);
begin
  if DMPessoa.Endereco.State in dsEditModes then
    DMPessoa.Endereco.Cancel;

  ModalResult := mrCancel;
end;

procedure TPessoaCadD.btnSaveClick(Sender: TObject);
begin
  if DMPessoa.Endereco.State in dsEditModes then
    DMPessoa.Endereco.Post;

  case Acao of
    tInsert: DMPessoa.AplicaInsercaoEndereco;
    tEdit: DMPessoa.AplicaEdicaoEndereco;
    TDelete: DMPessoa.AplicaDelecaoEndereco;
  end;

  ModalResult := mrOk;
end;

procedure TPessoaCadD.DBEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', chr(8)]) then
    Key := #0;
end;

procedure TPessoaCadD.DoShow;
begin
  inherited;
  case FAcao of
    tInsert, tEdit: btnSave.Caption := 'Save';
    TDelete: btnSave.Caption := 'Delete';
  end;

  if DBEdit1.CanFocus then
    DBEdit1.SetFocus;
end;

end.



