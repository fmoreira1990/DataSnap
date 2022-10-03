unit uPessoaCad;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Menus, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ExtDlgs;

type
  TPessoaCad = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    dsPessoas: TDataSource;
    DBGrid1: TDBGrid;
    OpenTextFileDialog: TOpenTextFileDialog;
    btnCEP: TButton;
    MemoAPI: TMemo;
    btnInsert: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    btnIportacao: TButton;
    btnAtualizar: TButton;
    procedure btnInsertClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnIportacaoClick(Sender: TObject);
    procedure btnCEPClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
  private
    procedure DoStatebuttons;
  protected
    procedure DoShow; override;
    { Private declarations }
  public
    { Public declarations }

  end;

var
  PessoaCad: TPessoaCad;

implementation

uses
  uDMPessoa,
  uPessoaCadM,
  uPessoa,
  StrUtils;

{$R *.dfm}

{ TPessoaCad }

procedure TPessoaCad.btnAtualizarClick(Sender: TObject);
begin
  DMPessoa.ConsultaPessoas;
end;

procedure TPessoaCad.btnCEPClick(Sender: TObject);
begin
  DMPessoa.AtualizarCEP;
end;

procedure TPessoaCad.btnDeleteClick(Sender: TObject);
begin
  DMPessoa.ConsultaPessoas(DMPessoa.Pessoas.FieldByName('idpessoa').AsLargeInt);
  PessoaCadM.Acao := TDelete;
  if PessoaCadM.ShowModal = mrOk then
  begin
    DMPessoa.ConsultaPessoas;
    DoStatebuttons;
  end;
end;

procedure TPessoaCad.btnEditClick(Sender: TObject);
begin
  DMPessoa.ConsultaPessoas(DMPessoa.Pessoas.FieldByName('idpessoa').AsLargeInt);
  PessoaCadM.Acao := tEdit;
  if PessoaCadM.ShowModal = mrOk then
  begin
    DMPessoa.ConsultaPessoas;
    DoStatebuttons;
  end;
end;

procedure TPessoaCad.btnInsertClick(Sender: TObject);
begin
  DMPessoa.InsertPessoa;
  PessoaCadM.Acao := tInsert;
  if PessoaCadM.ShowModal = mrOk then
  begin
    DMPessoa.ConsultaPessoas;
    DoStatebuttons;
  end;
end;

procedure TPessoaCad.btnIportacaoClick(Sender: TObject);
begin
  if OpenTextFileDialog.Execute then
  begin
    DMPessoa.FDBatchMoveTextReader.FileName := OpenTextFileDialog.FileName;
    DMPessoa.FDBatchMoveJSONWriter.FileName := ReplaceStr(OpenTextFileDialog.FileName, 'csv', 'json');
    DMPessoa.FDBatchMove.GuessFormat;
    DMPessoa.FDBatchMove.Execute;
    DMPessoa.AplicaInsercaoMassa;
    DMPessoa.ConsultaPessoas;
    DoStatebuttons;
  end;
end;

procedure TPessoaCad.DBGrid1DblClick(Sender: TObject);
begin
  if btnEdit.Enabled then
    btnEdit.Click;
end;

procedure TPessoaCad.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    if btnEdit.Enabled then
      btnEdit.Click;
end;

procedure TPessoaCad.DoShow;
begin
  inherited;
  DMPessoa.ConsultaPessoas;
  DoStatebuttons;
  if DBGrid1.CanFocus then
    DBGrid1.SetFocus;
end;

procedure TPessoaCad.DoStatebuttons;
begin
  if DMPessoa.Pessoas.Active then
  begin
    btnEdit.Enabled := DMPessoa.Pessoas.RecordCount > 0;
    btnDelete.Enabled := DMPessoa.Pessoas.RecordCount > 0;
    btnCEP.Enabled := DMPessoa.Pessoas.RecordCount > 0;
  end
end;

end.



