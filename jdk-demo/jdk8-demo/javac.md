# javac: LocalVariableTable vs. MethodParameters

javac -g:
```
      LocalVariableTable:
        Start  Length  Slot  Name   Signature
            0       9     0  args   [Ljava/lang/String;
```

javac -parameters:
```
    MethodParameters:
      Name                           Flags
      args
```
