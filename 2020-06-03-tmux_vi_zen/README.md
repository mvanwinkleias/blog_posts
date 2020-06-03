# tmux

## Splitting

Split vertically:

```
ctrl + b %
```

Split horizontally:

```
ctrl + b "
```

### Closing splits

```
ctrl + b x
```

### Navigation

```
ctrl + b    ^
          <-+->
            v
```

To cycle between splits:
```
ctrl + b o
```

# Maximize / Restore Pane

```
ctrl + b z
```

# VI

## Splitting

Split vertically:

```
ctrl + w v

or
:vsplit [file]
or
:vsp [file]

```

Split horizontally:
```
ctrl + w s

or
:split [file]
or
:sp [file]
```

Close split:
```
:q
```

### Navigating Splits

To go between splits:
```
ctrl + w +

     ^ k
 h <-+-> l
     v j
```


### Resizing Splits

Reset splits:
```
ctrl + w =
```

"Maximize" vertical split:
```
ctrl + w |  (pipe)
```

"Maximize" horizontal split:
```
ctrl + w _
```


## Editing a file

```
:e path/to/file
```


# Changing navigation bindings

```
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
```
