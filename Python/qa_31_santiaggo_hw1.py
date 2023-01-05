

    # 1-9. Создать переменные.

var_string = 'Terminator'
var_integer = 2
var_float = 5.1
var_bytes = bytes('Hello', encoding='UTF-8')
var_list = [5, 'tesla', 'new year', 23]
var_tuple = (1, 'peace', 7)
var_set = set('hello')
var_frozenset = frozenset('world')
var_dict = {'name': 'Santiago',
            'age': 35}

    # 10. Вывести в консоль все выше перечисленные переменные с добавлением типа данных.

print(var_string, type(var_string))
print(var_integer, type(var_integer))
print(var_float, type(var_float))
print(var_bytes, type(var_bytes))
print(var_list, type(var_list))
print(var_tuple, type(var_tuple))
print(var_set, type(var_set))
print(var_frozenset, type(var_frozenset))
print(var_dict, type(var_dict))

    # 11. Создать 2 переменные String, создать переменную в которой сканкатенируете эти переменные. Вывести в консоль.

item1 = 'How are'
item2 = 'you doing?'
item3 = item1 + ' ' + item2
print(item3)

    # 12. Вывести в одну строку переменные типа String и Integer используя “,” (Запятую).

print(var_string, var_integer)

    # 13. Вывести в одну строку переменные типа String и Integer используя “+” (Плюс).

print(var_string + ' ' + str(var_integer))