# GOALS

The point of the re-write:

    - rely less on external packages that break constantly and slow down the core editing experience
    - use modern nvim features (old nvim is available for machines with older nvim)

# PLUGIN LIST

- Plugin manager: 
    - attemp to use built-in but fall back to lazy

- Telescope:
    - literally just because of being able to grep the project is so useful

- which-key
    - because I forget key binds constantly

## removed plugins

- lsp-config & mason
    - I really hope that a note telling me to just copy the lsp-config's file for LSP servers will be enough...

    - Is this really a good idea??
        - it is useful to be able to just use mason to install LSPs when opening a new file
        - i hate mason at this point but it is useful since it 
            - easily updates all LSPs and formatters and DAPs,
            - tells me which LSPs, formatters and DAPs exist,
            - easily installs LSPs, formatters etc.
