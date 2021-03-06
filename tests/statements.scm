;;; Nil is handled
; x = nil
(program
  (variable_declaration
    (variable_declarator (identifier))
    (nil)))

;;; true is handled
; x = true
(program
  (variable_declaration
    (variable_declarator (identifier))
    (boolean)))

;;; false is handled
; x = false
(program
  (variable_declaration
    (variable_declarator (identifier))
    (boolean)))

;;; Simple assignment
; x = 1
(program
  (variable_declaration
    (variable_declarator (identifier))
    (number)))

;;; Simple assignment from variable
; x = y
(program
  (variable_declaration
    (variable_declarator (identifier))
    (identifier)))


;;; Accepts addition
; x = 1 + 2
(program
  (variable_declaration
    (variable_declarator (identifier))
    (binary_operation (number) (number))))

;;; Accepts addition of variables
; x = y + z
(program
  (variable_declaration
    (variable_declarator (identifier))
    (binary_operation (identifier) (identifier))))

;;; Can make local variables
; local x = 2
(program
  (variable_declaration
    (local)
    (variable_declarator (identifier))
    (number)))

;;; Can do multiple sets
; x, y, z = 1, 2, 3
(program
  (variable_declaration
    (variable_declarator (identifier))
    (variable_declarator (identifier))
    (variable_declarator (identifier))
    (number)
    (number)
    (number)))

;;; Can make an empty table
; t = {}
(program
  (variable_declaration
    (variable_declarator (identifier))
    (tableconstructor)))

;;; Can make a table with a number
; t = { 1 }
(program
  (variable_declaration
    name: (variable_declarator (identifier))
    value: (tableconstructor
            (fieldlist (field value: (number))))))

;;; Can make a table with a list of numbers
; t = { 1, 2, 3 }
(program
  (variable_declaration
    name: (variable_declarator (identifier))
    value: (tableconstructor
            (fieldlist
              (field value: (number))
              (field value: (number))
              (field value: (number))))))

;;; Can make a table with keys
; t = { x = 1, y = 2 }
(program
  (variable_declaration
    name: (variable_declarator (identifier))
    value: (tableconstructor
            (fieldlist
              (field
                name: (identifier)
                value: (number))
              (field
                name: (identifier)
                value: (number))))))


;;; Can make a table with expression keys
; t = { [x] = 1, ["y"] = 2 }
(program
  (variable_declaration
    name: (variable_declarator (identifier))
    value: (tableconstructor
            (fieldlist
              (field
                field_left_bracket: (field_left_bracket)
                key: (identifier)
                field_right_bracket: (field_right_bracket)
                value: (number))
              (field
                field_left_bracket: (field_left_bracket)
                key: (string)
                field_right_bracket: (field_right_bracket)
                value: (number))))))
        

;;; Can make a table with some expressions, some nothing and some keys
; t = { 1, 2, x = 1, ["y"] = 2 }
(program
  (variable_declaration
    name: (variable_declarator (identifier))
    value: (tableconstructor
            (fieldlist
              (field value: (number))
              (field value: (number))
              (field
                name: (identifier)
                value: (number))
              (field
                field_left_bracket: (field_left_bracket)
                key: (string)
                field_right_bracket: (field_right_bracket)
                value: (number))))))
        

;;; Can assign a function result
; foo = my_func()
(program
  (variable_declaration
    name: (variable_declarator (identifier))
    value: (function_call
            prefix: (identifier)
            (function_call_paren)
            (function_call_paren))))
      

;;; Can assign a function with params
; foo = my_func(x, 2, "3")
(program
  (variable_declaration
    name: (variable_declarator (identifier))
    value: (function_call
            prefix: (identifier)
            (function_call_paren)
            args: (function_arguments
                    (identifier)
                    (number)
                    (string))
            (function_call_paren))))

      

;;; Can call a function with a string value
; foo = my_func "hello world"
(program
  (variable_declaration
    name: (variable_declarator (identifier))
    value: (function_call
            prefix: (identifier)
            args: (string_argument))))

;;; Can call a function with a table value
; foo = my_func {}
(program
  (variable_declaration
    name: (variable_declarator (identifier))
    value: (function_call
            prefix: (identifier)
            args: (table_argument))))

;;; Can call a function returned by a function
; foo = my_func()()
(program
  (variable_declaration
    name: (variable_declarator (identifier))
    value: (function_call
            prefix: (function_call
                      prefix: (identifier)
                      (function_call_paren)
                      (function_call_paren))

            (function_call_paren)
            (function_call_paren))))

;;; Can call a table function // TODO: Decide if it makes sense with identifiers
; foo = my_table.func()
(program
  (variable_declaration
    (variable_declarator (identifier))
    (function_call
      (identifier) (identifier)
      (function_call_paren)
      (function_call_paren))))
      

;;; Can call a table function with lots of ids
; foo = my_table.func.x.y()
(program
  (variable_declaration
    (variable_declarator (identifier))
    (function_call
      (identifier) (identifier) (identifier) (identifier)
      (function_call_paren)
      (function_call_paren))))
      


;;; Can set namelist
; local x, y, z = 1, 2, 3
(program
  (variable_declaration
    (local)
    name: (variable_declarator (identifier))
    name: (variable_declarator (identifier))
    name: (variable_declarator (identifier))
    value: (number)
    value: (number)
    value: (number)))


;;; Can do comments
; -- Comment
; 
(program
  (comment))

;;; Multi lines
; x = 1
; y = 2
(program
  (variable_declaration (variable_declarator (identifier)) (number))
  (variable_declaration (variable_declarator (identifier)) (number)))
  

;;; Can do comments at the end of a line
; x = nil -- Comment
(program
  (variable_declaration
    (variable_declarator (identifier))
    (nil))
  (comment))

;;; Can handle parens around an expression
; x = (1)
(program
  (variable_declaration (variable_declarator (identifier)) (left_paren) (number) (right_paren)))


;;; Multi declaration
; local x, y = 1, 2
(program
  (variable_declaration
    (local)
    (variable_declarator
      (identifier))
    (variable_declarator
      (identifier))
    (number)
    (number)))

;;; Can do multi-line local with nothing else happening
; local documentation_node, name_node
; local x = 1
(program
  (variable_declaration
    (local)
    (variable_declarator
      (identifier))
    (variable_declarator
      (identifier)))
  (variable_declaration
    (local)
    (variable_declarator
      (identifier))
    (number)))

;;; Can do single statments
; local x
; x = {}
(program
  (variable_declaration
    (local)
    (variable_declarator
      (identifier)))
  (variable_declaration
    (variable_declarator
      (identifier))
    (tableconstructor)))

;;; Can do floats
; local x = 0.8
(program (variable_declaration (local) (variable_declarator (identifier)) (number)))
