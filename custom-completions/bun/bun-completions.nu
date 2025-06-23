# Bun completions for Nushell
# https://bun.sh

# Helper function to get package.json scripts
def "nu-complete bun scripts" [] {
  try {
    if (which package.json | is-empty) { 
      return [] 
    }
    open package.json | get scripts? | default {} | transpose | get column0
  } catch {
    []
  }
}

# Helper function to get npm packages from package.json
def "nu-complete bun packages" [] {
  try {
    if (which package.json | is-empty) { 
      return [] 
    }
    let pkg = open package.json
    let deps = $pkg | get dependencies? | default {} | transpose | get column0
    let devDeps = $pkg | get devDependencies? | default {} | transpose | get column0
    let optionalDeps = $pkg | get optionalDependencies? | default {} | transpose | get column0
    let peerDeps = $pkg | get peerDependencies? | default {} | transpose | get column0
    [$deps, $devDeps, $optionalDeps, $peerDeps] | flatten | uniq
  } catch {
    []
  }
}

# Helper function for targets
def "nu-complete bun targets" [] {
  ['browser', 'bun', 'node']
}

# Helper function for formats
def "nu-complete bun formats" [] {
  ['esm', 'cjs', 'iife']
}

# Helper function for sourcemap options
def "nu-complete bun sourcemap" [] {
  ['linked', 'inline', 'external', 'none']
}

# Helper function for coverage reporters
def "nu-complete bun coverage-reporters" [] {
  ['text', 'lcov']
}

# Helper function for test reporters
def "nu-complete bun test-reporters" [] {
  ['junit']
}

# Helper function for backends
def "nu-complete bun backends" [] {
  ['clonefile', 'hardlink', 'symlink', 'copyfile']
}

# Helper function for omit options
def "nu-complete bun omit" [] {
  ['dev', 'optional', 'peer']
}

# Helper function for packages options
def "nu-complete bun packages-option" [] {
  ['external', 'bundle']
}

# Helper function for install options
def "nu-complete bun install-options" [] {
  ['auto', 'fallback', 'force']
}

# Helper function for unhandled rejections
def "nu-complete bun unhandled-rejections" [] {
  ['strict', 'throw', 'warn', 'none', 'warn-with-error-code']
}

# Helper function for shell options
def "nu-complete bun shell" [] {
  ['bun', 'system']
}

# Helper function for DNS result order
def "nu-complete bun dns-order" [] {
  ['verbatim', 'ipv4first', 'ipv6first']
}

# Main bun command completions
export extern "bun" [
  command?: string@"nu-complete bun subcommands"   # Bun subcommand
  --help(-h)                                       # Display help and exit
  --version(-v)                                    # Print version and exit
  --revision                                       # Print version with revision and exit
  --watch                                          # Automatically restart on file change
  --hot                                            # Enable auto reload
  --no-clear-screen                                # Disable clearing terminal on reload
  --smol                                           # Use less memory, run GC more often
  --preload(-r): string                            # Import module before others
  --require: string                                # Alias of --preload for Node.js compatibility
  --import: string                                 # Alias of --preload for Node.js compatibility
  --inspect: string                                # Activate debugger
  --inspect-wait: string                           # Activate debugger, wait for connection
  --inspect-brk: string                            # Activate debugger with breakpoint
  --if-present                                     # Exit without error if entrypoint missing
  --no-install                                     # Disable auto install
  --install: string@"nu-complete bun install-options" # Configure auto-install behavior
  --eval(-e): string                               # Evaluate argument as script
  --print(-p): string                              # Evaluate and print result
  --prefer-offline                                 # Skip staleness checks, resolve from disk
  --prefer-latest                                  # Use latest versions, always check npm
  --port: int                                      # Set default port for Bun.serve
  --conditions: string                             # Pass custom conditions to resolve
  --fetch-preconnect: string                       # Preconnect to URL while loading
  --max-http-header-size: int                      # Max HTTP header size in bytes
  --dns-result-order: string@"nu-complete bun dns-order" # DNS lookup result order
  --expose-gc                                      # Expose gc() on global object
  --no-deprecation                                 # Suppress deprecation reporting
  --throw-deprecation                              # Make deprecation warnings into errors
  --title: string                                  # Set process title
  --zero-fill-buffers                              # Force Buffer.allocUnsafe to be zero-filled
  --redis-preconnect                               # Preconnect to $REDIS_URL at startup
  --no-addons                                      # Throw error on process.dlopen calls
  --unhandled-rejections: string@"nu-complete bun unhandled-rejections" # Unhandled rejection behavior
  --silent                                         # Don't print script command
  --elide-lines: int                               # Lines of script output when using --filter
  --filter(-F): string                             # Run script in matching workspace packages
  --bun(-b)                                        # Force use of Bun runtime instead of Node.js
  --shell: string@"nu-complete bun shell"          # Control shell for package.json scripts
  --env-file: string                               # Load environment variables from file
  --cwd: string                                    # Absolute path to resolve files from
  --config(-c): string                             # Specify path to Bun config file
]

def "nu-complete bun subcommands" [] {
  [
    'run',         # Execute a file with Bun
    'test',        # Run unit tests with Bun
    'x',           # Execute a package binary (bunx)
    'repl',        # Start a REPL session
    'exec',        # Run a shell script directly
    'install',     # Install dependencies (bun i)
    'add',         # Add a dependency (bun a)
    'remove',      # Remove a dependency (bun rm)
    'update',      # Update outdated dependencies
    'audit',       # Check for vulnerabilities
    'outdated',    # Display outdated dependencies
    'link',        # Register/link local npm package
    'unlink',      # Unregister local npm package
    'publish',     # Publish package to npm registry
    'patch',       # Prepare package for patching
    'pm',          # Package management utilities
    'info',        # Display package metadata
    'build',       # Bundle TypeScript & JavaScript
    'init',        # Start empty Bun project
    'create',      # Create project from template (bun c)
    'upgrade'      # Upgrade to latest Bun version
  ]
}

# Bun run command
export extern "bun run" [
  script?: string@"nu-complete bun scripts"        # Script name or file to run
  ...args: string                                  # Arguments to pass to script
  --watch                                          # Automatically restart on file change
  --hot                                            # Enable auto reload
  --no-clear-screen                                # Disable clearing terminal on reload
  --smol                                           # Use less memory
  --preload(-r): string                            # Import module before others
  --if-present                                     # Exit without error if script missing
  --silent                                         # Don't print script command
  --filter(-F): string                             # Run in matching workspace packages
  --bun(-b)                                        # Force Bun runtime
]

# Bun test command
export extern "bun test" [
  ...patterns: string                              # Test file patterns
  --timeout: int                                   # Per-test timeout in milliseconds
  --update-snapshots(-u)                           # Update snapshot files
  --rerun-each: int                                # Re-run each test file N times
  --only                                           # Only run tests marked with test.only()
  --todo                                           # Include tests marked with test.todo()
  --coverage                                       # Generate coverage profile
  --coverage-reporter: string@"nu-complete bun coverage-reporters" # Coverage reporter
  --coverage-dir: string                           # Coverage files directory
  --bail: int                                      # Exit after N failures
  --test-name-pattern(-t): string                  # Run tests matching regex
  --reporter: string@"nu-complete bun test-reporters" # Test reporter
  --reporter-outfile: string                       # Output file for reporter
]

# Bun install command
export extern "bun install" [
  ...packages: string                              # Packages to install
  --config(-c): string                             # Config file path
  --yarn(-y)                                       # Write yarn.lock file
  --production(-p)                                 # Don't install devDependencies
  --no-save                                        # Don't update package.json or lockfile
  --save                                           # Save to package.json
  --ca: string                                     # Certificate Authority certificate
  --cafile: string                                 # Path to CA certificate file
  --dry-run                                        # Don't install anything
  --frozen-lockfile                                # Disallow lockfile changes
  --force(-f)                                      # Always request latest versions
  --cache-dir: string                              # Cache directory path
  --no-cache                                       # Ignore manifest cache
  --silent                                         # Don't log anything
  --verbose                                        # Verbose logging
  --no-progress                                    # Disable progress bar
  --no-summary                                     # Don't print summary
  --no-verify                                      # Skip integrity verification
  --ignore-scripts                                 # Skip lifecycle scripts
  --trust                                          # Add to trustedDependencies
  --global(-g)                                     # Install globally
  --cwd: string                                    # Set specific cwd
  --backend: string@"nu-complete bun backends"     # Platform optimizations
  --registry: string                               # Registry URL
  --concurrent-scripts: int                        # Max concurrent lifecycle scripts
  --network-concurrency: int                       # Max concurrent network requests
  --save-text-lockfile                             # Save text lockfile
  --omit: string@"nu-complete bun omit"            # Exclude dependency types
  --lockfile-only                                  # Generate lockfile without installing
  --dev(-d)                                        # Add to devDependencies
  --optional                                       # Add to optionalDependencies
  --peer                                           # Add to peerDependencies
  --exact(-E)                                      # Add exact version
  --filter: string                                 # Install for matching workspaces
  --analyze(-a)                                    # Analyze & install all dependencies
  --only-missing                                   # Only add missing dependencies
]

# Bun add command
export extern "bun add" [
  ...packages: string                              # Packages to add
  --config(-c): string                             # Config file path
  --yarn(-y)                                       # Write yarn.lock file
  --production(-p)                                 # Don't install devDependencies
  --no-save                                        # Don't save to package.json
  --save                                           # Save to package.json
  --dry-run                                        # Don't install anything
  --frozen-lockfile                                # Disallow lockfile changes
  --force(-f)                                      # Always request latest versions
  --cache-dir: string                              # Cache directory path
  --no-cache                                       # Ignore manifest cache
  --silent                                         # Don't log anything
  --verbose                                        # Verbose logging
  --no-progress                                    # Disable progress bar
  --no-summary                                     # Don't print summary
  --no-verify                                      # Skip integrity verification
  --ignore-scripts                                 # Skip lifecycle scripts
  --trust                                          # Add to trustedDependencies
  --global(-g)                                     # Install globally
  --cwd: string                                    # Set specific cwd
  --backend: string@"nu-complete bun backends"     # Platform optimizations
  --registry: string                               # Registry URL
  --dev(-d)                                        # Add to devDependencies
  --optional                                       # Add to optionalDependencies
  --peer                                           # Add to peerDependencies
  --exact(-E)                                      # Add exact version
  --filter: string                                 # Install for matching workspaces
]

# Bun remove command
export extern "bun remove" [
  ...packages: string@"nu-complete bun packages"   # Packages to remove
  --config(-c): string                             # Config file path
  --yarn(-y)                                       # Write yarn.lock file
  --production(-p)                                 # Don't install devDependencies
  --no-save                                        # Don't save to package.json
  --save                                           # Save to package.json
  --dry-run                                        # Don't install anything
  --frozen-lockfile                                # Disallow lockfile changes
  --force(-f)                                      # Always request latest versions
  --cache-dir: string                              # Cache directory path
  --no-cache                                       # Ignore manifest cache
  --silent                                         # Don't log anything
  --verbose                                        # Verbose logging
  --no-progress                                    # Disable progress bar
  --no-summary                                     # Don't print summary
  --global(-g)                                     # Remove globally
  --cwd: string                                    # Set specific cwd
]

# Bun update command
export extern "bun update" [
  ...packages: string@"nu-complete bun packages"   # Packages to update
  --config(-c): string                             # Config file path
  --yarn(-y)                                       # Write yarn.lock file
  --production(-p)                                 # Don't install devDependencies
  --no-save                                        # Don't save to package.json
  --save                                           # Save to package.json
  --dry-run                                        # Don't install anything
  --frozen-lockfile                                # Disallow lockfile changes
  --force(-f)                                      # Always request latest versions
  --cache-dir: string                              # Cache directory path
  --no-cache                                       # Ignore manifest cache
  --silent                                         # Don't log anything
  --verbose                                        # Verbose logging
  --no-progress                                    # Disable progress bar
  --no-summary                                     # Don't print summary
  --global(-g)                                     # Update globally
  --cwd: string                                    # Set specific cwd
]

# Bun build command
export extern "bun build" [
  ...entrypoints: string                           # Entry point files
  --production                                     # Set NODE_ENV=production and minify
  --compile                                        # Generate standalone executable
  --bytecode                                       # Use bytecode cache
  --watch                                          # Auto restart on file change
  --no-clear-screen                                # Disable clearing terminal on reload
  --target: string@"nu-complete bun targets"       # Target environment
  --outdir: string                                 # Output directory
  --outfile: string                                # Output file
  --sourcemap: string@"nu-complete bun sourcemap"  # Sourcemap option
  --banner: string                                 # Add banner to output
  --footer: string                                 # Add footer to output
  --format: string@"nu-complete bun formats"       # Module format
  --root: string                                   # Root directory for multiple entries
  --splitting                                      # Enable code splitting
  --public-path: string                            # Prefix for import paths
  --external(-e): string                           # Exclude module from transpilation
  --packages: string@"nu-complete bun packages-option" # Bundle or keep dependencies external
  --entry-naming: string                           # Customize entry filenames
  --chunk-naming: string                           # Customize chunk filenames
  --asset-naming: string                           # Customize asset filenames
  --react-fast-refresh                             # Enable React Fast Refresh
  --no-bundle                                      # Transpile only, don't bundle
  --emit-dce-annotations                           # Re-emit DCE annotations
  --minify                                         # Enable all minification
  --minify-syntax                                  # Minify syntax and inline data
  --minify-whitespace                              # Minify whitespace
  --minify-identifiers                             # Minify identifiers
  --css-chunking                                   # Chunk CSS files together
  --conditions: string                             # Pass custom conditions
  --app                                            # Build web app with Bun Bake
  --server-components                              # Enable server components
  --env: string                                    # Inline environment variables
  --windows-hide-console                           # Hide console on Windows
  --windows-icon: string                           # Windows executable icon
]

# Bun x (bunx) command
export extern "bun x" [
  package: string                                  # Package to execute
  ...args: string                                  # Arguments for the package
  --bun(-b)                                        # Force Bun runtime
]

# Bun create command
export extern "bun create" [
  template?: string                                # Template name
  ...args: string                                  # Template arguments
  --cwd: string                                    # Set specific cwd
]

# Bun init command
export extern "bun init" [
  --cwd: string                                    # Set specific cwd
]

# Bun link command
export extern "bun link" [
  package?: string                                 # Package to link
  --global(-g)                                     # Link globally
]

# Bun unlink command
export extern "bun unlink" [
  --global(-g)                                     # Unlink globally
]

# Bun patch command
export extern "bun patch" [
  package: string                                  # Package to patch
]

# Bun publish command
export extern "bun publish" [
  --dry-run                                        # Don't actually publish
  --access: string                                 # Set package access
  --tag: string                                    # Set package tag
]

# Bun info command
export extern "bun info" [
  package?: string                                 # Package to get info about
  --registry: string                               # Registry URL
]

# Bun audit command
export extern "bun audit" [
  --audit-level: string                            # Audit level
]

# Bun outdated command
export extern "bun outdated" [
  --format: string                                 # Output format
]

# Bun pm command
export extern "bun pm" [
  subcommand?: string                              # PM subcommand
  ...args: string                                  # Subcommand arguments
]

# Bun upgrade command
export extern "bun upgrade" [
  --canary                                         # Upgrade to canary version
]

# Bun repl command
export extern "bun repl" [
  --print                                          # Print result of expressions
]

# Bun exec command
export extern "bun exec" [
  command: string                                  # Command to execute
  ...args: string                                  # Command arguments
]