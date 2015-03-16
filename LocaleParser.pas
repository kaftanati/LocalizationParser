unit LocaleParser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Declare;

type
  TForm1 = class(TForm)
    ButtonOpen: TButton;
    ButtonSave: TButton;
    OpenDialog1: TOpenDialog;
    MemoFound: TMemo;
    Label1: TLabel;
    ButtonParse: TButton;
    ButtonAvtoFM: TButton;
    ButtonAvtoCE: TButton;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    etCommon: TEdit;
    etLocalized: TEdit;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    etAddCommon: TEdit;
    etAddLocalized: TEdit;
    Label6: TLabel;
    etAddReplacing: TEdit;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    etComment: TEdit;
    etlanguageCode: TEdit;
    Label9: TLabel;
    etLanguageParentCode: TEdit;
    GroupBox4: TGroupBox;
    Label10: TLabel;
    etFilename: TEdit;
    chbAutoexit: TCheckBox;
    ButtonClearMemo: TButton;
    procedure ButtonOpenClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonParseClick(Sender: TObject);
    procedure ButtonAvtoFMClick(Sender: TObject);
    procedure ButtonAvtoCEClick(Sender: TObject);

    procedure FileToMemo();
    procedure ValueOut();
    procedure ValueDoXML();
    procedure LogAdd(log: String);
    procedure ParseString(strbuff: String);
    procedure ParseLocales(strbuff: String);
    procedure ParseAliasLocales(strbuff: String);
    procedure ParseValues(strbuff: String);
    procedure ParseRepeatValues(strbuff: String);
    procedure ParseCommonValues(strbuff: String);
    function ParseColumn(strbuff: String): TColumns;
    procedure SetAliasValues();

    procedure ParseSource();
    procedure ButtonClearMemoClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ButtonAvtoCEClick(Sender: TObject);
begin
  if not(fileChoosen) then
    AssignFile(fileMemo, etFilename.Text);
  parseAdditional := true;
  ParseSource();
  ValueDoXML();
  if chbAutoexit.Checked then
    Close();
end;

procedure TForm1.ButtonAvtoFMClick(Sender: TObject);
begin
  if not(fileChoosen) then
    AssignFile(fileMemo, etFilename.Text);
  ParseSource();
  ValueDoXML();
  if chbAutoexit.Checked then
    Close();
end;

procedure TForm1.ButtonClearMemoClick(Sender: TObject);
begin
  MemoFound.Clear;
end;

procedure TForm1.ButtonOpenClick(Sender: TObject);
begin
  FileToMemo();
end;

procedure TForm1.FileToMemo();
begin
  OpenDialog1.Title := 'Choose file';
  OpenDialog1.InitialDir := GetCurrentDir;
  OpenDialog1.Filter :=
    'TSV files (*.tsv)|*.tsv|All files (*.*)|*.*';
  if OpenDialog1.Execute then
  begin
    MemoFound.Lines.Clear;
    MemoFound.Hint := 'File loaded successfull: ' + OpenDialog1.fileName;
    MemoFound.ShowHint := true;

    LogAdd('File loaded successfull:');

    LogAdd('   ' + OpenDialog1.fileName);
    AssignFile(fileMemo, OpenDialog1.fileName);
    fileChoosen := true;
    // ValueOut();

  end
  else
  begin
    LogAdd('File opening canceled!');
  end;

end;

procedure TForm1.ValueOut();
var
  i, j: integer;
  str: string;
begin
  for i := 1 to value_count - 1 do
  begin
    str := '';
    if values[i].section <> '' then
      str := str + 'sec[' + values[i].section + '] ';
    if values[i].category <> '' then
      str := str + 'cat[' + values[i].category + '] ';

    str := str + 'name[' + values[i].name + ']';

    for j := 1 to locale_count - 1 do
    begin
      str := str + ' ' + locales[j] + '[' + values[i].val[j] + ']';
    end;

    LogAdd(str);

  end;

end;

procedure TForm1.ValueDoXML();
var
  i, j: integer;
  filecom, filexml: TextFile;
  Path: String;
begin

  CreateDir('res');
  CreateDir('res\values');

  AssignFile(filecom, 'res\values\string_common.xml');
  ReWrite(filecom);

  WriteLn(filecom, '<?xml version="1.0" encoding="utf-8"?>');
  WriteLn(filecom, '<resources>');

  for j := 1 to locale_count do
    if loc_ready[j] then
    begin
      if (j = 1) then
      AssignFile(filexml, 'res\values\string.xml')
      else
      begin
        CreateDir('res\values-' + locales[j]);
        AssignFile(filexml,
          'res\values-' + locales[j] + '\string.xml');
      end;

      ReWrite(filexml);

      WriteLn(filexml, '<?xml version="1.0" encoding="utf-8"?>');
      WriteLn(filexml, '<resources>');

      for i := 1 to value_count do
      begin
        if (values[i].val[j] <> '') then
        begin

          if values[i].typ = 1 then
          begin

            if values[i].section <> '' then
              WriteLn(filexml);
            if values[i].section <> '' then
              WriteLn(filexml, '    <!-- ' + values[i].section + ' -->');
            if (values[i].category <> '') and (values[i].section = '') then
              WriteLn(filexml);
            if values[i].category <> '' then
              WriteLn(filexml, '    <!-- ' + values[i].category + ' -->');
            if values[i].name <> '' then
              WriteLn(filexml,
                '    <string name="' + values[i].name + '">' + values[i].val
                  [j] + '</string>');
          end;

          if (values[i].typ = 2) and (j = 1) then
          begin
            if values[i].section <> '' then
              WriteLn(filecom);
            if values[i].section <> '' then
              WriteLn(filecom, '    <!-- ' + values[i].section + ' -->');
            if (values[i].category <> '') and (values[i].section = '') then
              WriteLn(filecom);
            if values[i].category <> '' then
              WriteLn(filecom, '    <!-- ' + values[i].category + ' -->');
            if values[i].name <> '' then
              WriteLn(filecom,
                '    <string name="' + values[i].name + '">' + values[i].val
                  [j] + '</string>');
          end;
        end;
      end;

      WriteLn(filexml, '</resources>');
      CloseFile(filexml);

      LogAdd('Locale strings created!');

    end;

  WriteLn(filecom, '</resources>');
  CloseFile(filecom);

  for j := 1 to locale_count do
    LogAdd('string-' + locales[j] + '.xml');

end;

procedure TForm1.LogAdd(log: String);
begin
  MemoFound.Lines.Add(log);
end;

procedure TForm1.ParseString(strbuff: String);
var
  c: char;
begin
  // Form1.MemoFound.Lines.Add(log);

  c := strbuff[1];

  if (c = etlanguageCode.Text[1]) then
    ParseLocales(strbuff);

  if (c = etLanguageparentCode.Text[1]) then
    ParseAliasLocales(strbuff);

  if (c = etCommon.Text[1]) then
    ParseCommonValues(strbuff);

  if (c = etLocalized.Text[1]) then
    ParseValues(strbuff);

  c := strbuff[1];

  if parseAdditional then
  begin
    // LogAdd(' CheckBoxAll Checked');
    if (c = etAddCommon.Text[1]) then
      ParseCommonValues(strbuff);
    if (c = etAddLocalized.Text[1]) then
      ParseValues(strbuff);
    if (c = etAddReplacing.Text[1]) then
      ParseRepeatValues(strbuff);
  end;

end;

procedure TForm1.ParseLocales(strbuff: String);
var
  c: char;
  res: TColumns;
  i: integer;
begin
  res := ParseColumn(strbuff);
  locale_count := length(res) - 6;
  SetLength(locales, locale_count + 1);
  SetLength(loc_ready, locale_count + 1);
  for i := 1 to locale_count do
  begin
    locales[i] := res[i + 4];

    if length(locales[i]) < 6 then
      loc_ready[i] := true
    else
      loc_ready[i] := false;

  end;
end;

procedure TForm1.ParseAliasLocales(strbuff: String);
var
  c: char;
  res: TColumns;
  i: integer;
begin
  res := ParseColumn(strbuff);
  locale_count := length(res) - 6;
  SetLength(alias_locales, locale_count + 1);
  LogAdd('Found ' + IntToStr(locale_count) + ' locales');
  for i := 1 to locale_count do
  begin
    alias_locales[i] := res[i + 4];
    LogAdd('locale[' + IntToStr(i) + '] = ' + locales[i] + ' [' + alias_locales
        [i] + ']');
  end;
end;

procedure TForm1.ParseValues(strbuff: String);
var
  res: TColumns;
  i: integer;
begin
  res := ParseColumn(strbuff);
  value_count := value_count + 1;
  SetLength(values, value_count + 1);

  SetLength(values[value_count].val, locale_count + 1);

  values[value_count].typ := 1;
  values[value_count].section := res[2];
  values[value_count].category := res[3];
  values[value_count].name := res[4];

  for i := 1 to locale_count do
  begin
    values[value_count].val[i] := res[4 + i];
  end;
end;

procedure TForm1.ParseRepeatValues(strbuff: String);
var
  res: TColumns;
  i, j: integer;
begin
  res := ParseColumn(strbuff);

  for i := 0 to value_count do
    if (values[i].name = res[4]) then
    begin
      values[i].typ := 1;
      values[i].section := res[2];
      values[i].category := res[3];
      values[i].name := res[4];
      for j := 1 to locale_count do
      begin
        values[i].val[j] := res[4 + j];
      end;
    end;
end;

procedure TForm1.ParseCommonValues(strbuff: String);
var
  res: TColumns;
  i: integer;
begin
  res := ParseColumn(strbuff);
  value_count := value_count + 1;
  SetLength(values, value_count + 1);

  SetLength(values[value_count].val, locale_count + 1);

  values[value_count].typ := 2;
  values[value_count].section := res[2];
  values[value_count].category := res[3];
  values[value_count].name := res[4];

  for i := 1 to locale_count do
  begin
    values[value_count].val[i] := res[4 + i];
  end;

end;

procedure TForm1.SetAliasValues();
var
  res: TColumns;
  i, j, k: integer;
begin

  for i := 1 to value_count do
    for j := 1 to locale_count do
      if ((values[i].val[j] = '') AND ((values[i].typ = 1) OR
            (values[i].typ = 6))) then
      begin
        // LogAdd('name [] = ' + values[i].name);
        // LogAdd('alias_locales = ' + alias_locales[j]);
        for k := 1 to locale_count do
        begin
          // LogAdd('locales[' + IntToStr(k) + ']' + locales[k]);
          if ((locales[k] = alias_locales[j]) AND (locales[k] <> '')) then
            values[i].val[j] := values[i].val[k];
        end;
      end;
end;

function TForm1.ParseColumn(strbuff: String): TColumns;
var
  res: TColumns;
  str: string;
  i, col_count: integer;

begin
  col_count := 1;

  for i := 1 to length(strbuff) do
  begin
    if (strbuff[i] <> chr(9)) then
      str := str + strbuff[i]
    else
    begin
      SetLength(res, col_count + 1);
      res[col_count] := str;
      str := '';
      col_count := col_count + 1;
    end;
    SetLength(res, col_count + 1);
    res[col_count] := str;
  end;
  // LogAdd('Locales: ' + strbuff);
  Result := res;
end;

procedure TForm1.ButtonParseClick(Sender: TObject);
begin
  if parseAdditional then
    ParseSource()
  else
    LogAdd('File not setted!');

end;

procedure TForm1.ParseSource();
Var
  strbuff: string;
begin

  Reset(fileMemo);

  While not eof(fileMemo) do
  begin
    Readln(fileMemo, strbuff);
    ParseString(strbuff);
  end;

  CloseFile(fileMemo);
  LogAdd('File parsed successfull.');

  SetAliasValues();

  LogAdd('Setted alias values for missing resources.');

end;

procedure TForm1.ButtonSaveClick(Sender: TObject);
begin
  ValueDoXML();
end;

end.
