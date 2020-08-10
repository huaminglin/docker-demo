# clhsdb

## In the hsdb console, try some commands

```
universe
Heap Parameters:
ParallelScavengeHeap [ PSYoungGen [ eden =  [0x0000000770d00000,0x0000000771054928,0x0000000771300000] , from =  [0x0000000771480000,0x00000007715af850,0x0000000771600000] , to =  [0x0000000771300000,0x0000000771300000,0x0000000771480000]  ] PSOldGen [  [0x00000006d2600000,0x00000006d2803038,0x00000006d2b80000]  ]  ]
```

scanoops 0x00000006d2600000 0x00000006d2b80000

```
inspect 0x0000000770d1fcb8
instance of "bad MethodHandle constant #" @ 0x0000000770d1fcb8 @ 0x0000000770d1fcb8 (size = 24)
_mark: 1
_metadata._compressed_klass: InstanceKlass for java/lang/String
value: [C @ 0x0000000770d1fcd0 Oop for [C @ 0x0000000770d1fcd0
hash: 0
```
