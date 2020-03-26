{В АВЛ-дереве найти все узлы, у которых высоты левых и правых поддеревьев равны. Вывести значения этих узлов.}

type
  PItem = ^Item;
  Item = record
    data: integer;
    left: PItem;
    right: PItem;
  end;

procedure AddItem(x: integer; var root: pItem);//Добавление элементов в дерево
begin
  if root = nil then //Если корень = 0
    begin
      new(root); //Создаём новый корень
     root^.data := x; //Значение корня
     root^.left := nil; //Левое поддерево
     root^.right := nil;//Правое поддерево
    end
  else //иначе
    begin
      if x < root^.data then //Если х меньше значения корня
        AddItem(x, root^.left) //добавляем х в левое поддерево
      else //если больше значения корня
        AddItem(x, root^.right);//в правое поддерево
    end;
end;

procedure PrintTree(tree: PItem; ots: integer); //Печать дерева
begin
  if Tree <> nil then //Если дерево не равно 0, то
    if Tree^.right <> nil then //Если правое поддерево не равно 0, то
      PrintTree(tree^.right, ots + 4); //печатаем правое поддерево
  writeln(' ':ots, tree^.data, ' '); //отс - форматирование
  if Tree^.left <> nil then //Если левое поддерево не равно 0, то
    PrintTree(Tree^.left, ots + 4); //печатаем левое поддерево
end;

function Heigth(tree: PItem): byte; //функция высота дерева
var
  l,r:byte;
begin
  result:=0;
  if tree <> nil then //Если дерево не равно 0, то
    begin
      l:=Heigth(tree^.left)+1; //(Считаем) Сохраняем высоту левого поддерева
      r:=Heigth(tree^.right)+1; //(Считаем) Сохраняем высоту правого поддерева
      if l>r then //Если левая часть больше правой, то
        result:=l //Результат равен 1
      else 
        result:=r; //Иначе равен правой части
    end;
end;

function AVL(tree: PItem): byte; //Проверка дерева на АВЛ (АВЛ-дерево - сбалансированное по высоте бинарное дерево поиска: для каждой его вершины высота её двух поддеревьев различается не более чем на 1)
var
  l, r: byte;
begin
  result:=1; 
  if tree <> nil then //Если дерево не равно 0, то
    begin
      if (AVL(tree^.Left)=1) and (AVL(tree^.right)=1) then //Если Левое поддерево = 1 и правое = 1, то
        begin
          l:=Heigth(tree^.left); //Л присваиваем высоту левого поддерева
          r:=Heigth(tree^.right); //Р присваиваем высоту правого
          if (l=r+1) or (l+1=r) or (l=r) then //Проверка на АВЛ (Если Л и Р либо равны, либо различаются всего на единицу, то)
            result:=1 //Результат=1
          else
            result:=0; //Иначе - 0
        end
      else
        result:=0; //Это для случая, когда дерево первоначально нулевое
      end;
end;

procedure zadone(tree: PItem); //Вывод значения узлов
begin
  if tree <> nil then //Если Дерево не нулевое, то
    begin
      if Heigth(tree^.left) = Heigth(tree^.right) then //Если Высоты правого и левого поддерева равны, то
        begin
          printtree(tree, 2); //Выводим дерево
          writeln;
        end;
      zadone(tree^.right); //Выводим правый узел
      zadone(tree^.left); //Выводим левый узел
    end;
end;

var
  root: PItem;
  x: integer;
  n: integer;
  i: integer;

begin
  Writeln('Введите кол-во элементов');
  readln(n);
  for i := 1 to n do
    begin
      Writeln('Введите ', i , ' элемент');
      readln(x);
      AddItem(x, root);
    end;
  PrintTree(root, 2);
  if AVL(root) = 1 then 
    begin
      writeln('Дерево является АВЛ');
      Zadone(root);
    end
  else
    writeln('Дерево не является АВЛ, введите АВЛ- дерево');
end.   
