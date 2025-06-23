# Go completions for Nushell
# https://go.dev

# Helper function to get go packages in current module
def "nu-complete go packages" [] {
  try {
    ^go list ./... | lines
  } catch {
    []
  }
}

# Helper function to get available build modes
def "nu-complete go buildmodes" [] {
  [
    'archive',
    'c-archive', 
    'c-shared',
    'default',
    'shared',
    'exe',
    'pie',
    'plugin'
  ]
}

# Helper function to get Go environment variables
def "nu-complete go env vars" [] {
  try {
    ^go env | lines | each { |line| $line | str replace '=' ' ' } | str join "\n" | from ssv --noheaders | get column1
  } catch {
    []
  }
}

# Helper function for mod subcommands
def "nu-complete go mod subcommands" [] {
  [
    'download',
    'edit', 
    'graph',
    'init',
    'tidy',
    'vendor',
    'verify',
    'why'
  ]
}

# Helper function for test flags
def "nu-complete go test flags" [] {
  [
    'bench',
    'benchmem',
    'count',
    'cover',
    'covermode',
    'coverpkg',
    'cpu',
    'failfast',
    'list',
    'parallel',
    'run',
    'short',
    'timeout',
    'v'
  ]
}

# Helper function for build constraint tags
def "nu-complete go build tags" [] {
  [
    'linux',
    'darwin', 
    'windows',
    'amd64',
    'arm64',
    '386',
    'arm',
    'debug',
    'release'
  ]
}

# Go command completions
export extern "go" [
  command?: string@"nu-complete go subcommands"  # Go subcommand
  --help(-h)                                     # Show help
  --version                                      # Show version
]

def "nu-complete go subcommands" [] {
  [
    'bug',         # start a bug report  
    'build',       # compile packages and dependencies
    'clean',       # remove object files and cached files
    'doc',         # show documentation for package or symbol
    'env',         # print Go environment information
    'fix',         # update packages to use new APIs
    'fmt',         # gofmt (reformat) package sources
    'generate',    # generate Go files by processing source
    'get',         # add dependencies to current module and install them
    'install',     # compile and install packages and dependencies
    'list',        # list packages or modules
    'mod',         # module maintenance
    'work',        # workspace maintenance
    'run',         # compile and run Go program
    'telemetry',   # manage telemetry data and settings
    'test',        # test packages
    'tool',        # run specified go tool
    'version',     # print Go version
    'vet'          # report likely mistakes in packages
  ]
}

# Go build command
export extern "go build" [
  ...packages: string@"nu-complete go packages"  # Packages to build
  --output(-o): string                           # Output file or directory
  --buildmode: string@"nu-complete go buildmodes" # Build mode
  --tags: string@"nu-complete go build tags"    # Build tags
  --race                                         # Enable data race detection
  --msan                                         # Enable memory sanitizer
  --asan                                         # Enable address sanitizer
  --cover                                        # Enable code coverage
  --covermode: string                            # Coverage analysis mode (set,count,atomic)
  --coverpkg: string                             # Coverage analysis packages
  --verbose(-v)                                  # Print package names as compiled
  --work                                         # Print temp work directory
  --ldflags: string                              # Linker flags
  --gcflags: string                              # Compiler flags
  --asmflags: string                             # Assembler flags
  --gccgoflags: string                           # gccgo flags
  --mod: string                                  # Module download mode (readonly, vendor, mod)
  --modcacherw                                   # Leave module cache read-write
  --trimpath                                     # Remove file system paths from executable
  --json                                         # Emit build output in JSON
]

# Go run command
export extern "go run" [
  ...files: string                               # Go files or packages to run
  --exec: string                                 # Program to run binary
  --race                                         # Enable data race detection
  --msan                                         # Enable memory sanitizer
  --asan                                         # Enable address sanitizer
  --cover                                        # Enable code coverage
  --covermode: string                            # Coverage analysis mode
  --coverpkg: string                             # Coverage analysis packages
  --verbose(-v)                                  # Print package names
  --work                                         # Print temp work directory
  --ldflags: string                              # Linker flags
  --gcflags: string                              # Compiler flags
  --mod: string                                  # Module download mode
  --trimpath                                     # Remove file system paths
]

# Go test command
export extern "go test" [
  ...packages: string@"nu-complete go packages"  # Packages to test
  --bench: string                                # Run benchmarks matching regexp
  --benchmem                                     # Print memory allocation stats for benchmarks
  --benchtime: string                            # Run benchmarks for given duration
  --count: int                                   # Run tests and benchmarks n times
  --cover                                        # Enable coverage analysis
  --covermode: string                            # Coverage analysis mode
  --coverpkg: string                             # Coverage analysis packages
  --cpu: string                                  # Comma-separated list of cpu counts
  --failfast                                     # Stop on first test failure
  --json                                         # Convert test output to JSON
  --list: string                                 # List tests matching regexp
  --parallel: int                                # Maximum test parallelism
  --run: string                                  # Run tests matching regexp
  --short                                        # Tell long-running tests to shorten
  --timeout: string                              # Test timeout
  --verbose(-v)                                  # Verbose output
  --race                                         # Enable data race detection
  --msan                                         # Enable memory sanitizer
  --asan                                         # Enable address sanitizer
  --work                                         # Print temp work directory
  --args                                         # Pass remaining args to test binary
]

# Go mod command
export extern "go mod" [
  subcommand: string@"nu-complete go mod subcommands"  # Mod subcommand
  ...args: string                                       # Additional arguments
]

# Go mod init
export extern "go mod init" [
  module?: string                                # Module path
]

# Go mod tidy
export extern "go mod tidy" [
  --verbose(-v)                                  # Verbose output
  --go: string                                   # Go version for go.mod
]

# Go mod download
export extern "go mod download" [
  ...modules: string                             # Modules to download
  --json                                         # Print JSON output
]

# Go get command
export extern "go get" [
  ...packages: string                            # Packages to get
  --update(-u)                                   # Update to latest versions
  --patch                                        # Update to latest patch versions
  --insecure                                     # Allow insecure connections
  --verbose(-v)                                  # Verbose output
  --fix                                          # Run fix tool on downloaded packages
  --tags: string                                 # Build tags
]

# Go install command  
export extern "go install" [
  ...packages: string@"nu-complete go packages"  # Packages to install
  --race                                         # Enable data race detection
  --msan                                         # Enable memory sanitizer
  --asan                                         # Enable address sanitizer
  --cover                                        # Enable code coverage
  --verbose(-v)                                  # Print package names
  --work                                         # Print temp work directory
  --ldflags: string                              # Linker flags
  --gcflags: string                              # Compiler flags
  --tags: string                                 # Build tags
  --mod: string                                  # Module download mode
  --trimpath                                     # Remove file system paths
]

# Go list command
export extern "go list" [
  ...packages: string@"nu-complete go packages"  # Packages to list
  --compiled                                     # Set CompiledGoFiles to compiled Go source files
  --deps                                         # Iterate over dependencies too
  --export(-e)                                   # Set export data
  --find(-f)                                     # Load and vendor packages but not dependencies
  --json                                         # Print in JSON format
  --modules(-m)                                  # List modules instead of packages
  --test                                         # Include test files
  --versions                                     # List available versions of modules
]

# Go clean command
export extern "go clean" [
  ...packages: string@"nu-complete go packages"  # Packages to clean
  --cache                                        # Remove entire go build cache
  --testcache                                    # Remove test cache
  --modcache                                     # Remove module cache
  --fuzzcache                                    # Remove fuzz cache
  --verbose(-v)                                  # Print removed files
  --dry-run(-n)                                  # Print commands but don't run
]

# Go env command
export extern "go env" [
  ...vars: string@"nu-complete go env vars"      # Environment variables to show
  --json                                         # Print in JSON format
  --unset(-u): string                            # Unset environment variable
  --write(-w): string                            # Write VAR=VALUE to go env file
]

# Go fmt command
export extern "go fmt" [
  ...packages: string@"nu-complete go packages"  # Packages to format
  --mod: string                                  # Module download mode
  --verbose(-v)                                  # Print package names
  --dry-run(-n)                                  # Print commands but don't run
]

# Go vet command
export extern "go vet" [
  ...packages: string@"nu-complete go packages"  # Packages to vet
  --verbose(-v)                                  # Print package names
  --all                                          # Run all analyzers
  --json                                         # Print in JSON format
  --mod: string                                  # Module download mode
]

# Go doc command
export extern "go doc" [
  package?: string                               # Package or symbol to document
  --all                                          # Show all documentation
  --cmd                                          # Treat package as command
  --short                                        # One-line representation for each symbol
  --src                                          # Show source code
  --unexported(-u)                               # Show unexported symbols
]

# Go version command
export extern "go version" [
  --modules(-m)                                  # Print module versions
  --verbose(-v)                                  # Print verbose version info
]

# Go generate command
export extern "go generate" [
  ...packages: string@"nu-complete go packages"  # Packages to generate
  --run: string                                  # Run only matching generators
  --skip: string                                 # Skip matching generators
  --verbose(-v)                                  # Print package names and generators
  --dry-run(-n)                                  # Print commands but don't run
]

# Go work command
export extern "go work" [
  subcommand: string                             # Work subcommand (init, use, edit, sync)
  ...args: string                                # Additional arguments
]

# Go tool command
export extern "go tool" [
  tool?: string                                  # Tool to run
  ...args: string                                # Tool arguments
  --list                                         # List available tools
]