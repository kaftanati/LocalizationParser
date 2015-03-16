unit Declare;

interface

const

 comment_code = '0';
 lang_code = '1';
 lang_parent_code = '2';


type
  TColumns = array of string;

  Value = record // ресурс
    typ: integer; // тип ресурса - 1 (локализованный), 2(общий), 6(локализованный CE) , 7(общий CE)
    section: string[50]; // раздел
    category: string[50]; // категория
    name: string[50]; // наименование ресурса
    val: TColumns; // массив локализованных ресурсов
  end;

Var
  values: array of Value; // массив ресурсов
  locales: array of string; // массив локалей
  loc_ready: array of boolean; // массив готовностей локалей
  alias_locales: array of string;  // массив локалей-подстановок
  value_count: integer;
  locale_count: integer;
  fileMemo: text;
  fileChoosen: boolean;
  parseAdditional: boolean;

implementation

end.
