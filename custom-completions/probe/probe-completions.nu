# Probe completions for Nushell
# https://github.com/probe-rs/probe

# Helper function for programming languages
def "nu-complete probe languages" [] {
  [
    'rust', 'rs',
    'javascript', 'js', 'jsx', 
    'typescript', 'ts', 'tsx',
    'python', 'py',
    'go',
    'c', 'h',
    'cpp', 'cc', 'cxx', 'hpp', 'hxx',
    'java',
    'ruby', 'rb',
    'php',
    'swift',
    'csharp', 'cs'
  ]
}

# Helper function for output formats
def "nu-complete probe formats" [] {
  ['terminal', 'markdown', 'plain', 'json', 'xml', 'color']
}

# Helper function for search output formats
def "nu-complete probe search formats" [] {
  ['terminal', 'markdown', 'plain', 'json', 'xml', 'color']
}

# Helper function for extract output formats
def "nu-complete probe extract formats" [] {
  ['markdown', 'plain', 'json', 'xml', 'color']
}

# Helper function for query output formats
def "nu-complete probe query formats" [] {
  ['markdown', 'plain', 'json', 'xml', 'color']
}

# Helper function for reranker options
def "nu-complete probe rerankers" [] {
  ['bm25']
}

# Helper function for prompt templates
def "nu-complete probe prompts" [] {
  ['engineer', 'architect']
}

# Main probe command completions
export extern "probe" [
  command?: string@"nu-complete probe subcommands"   # Probe subcommand
  pattern?: string                                   # Search pattern (when no subcommand)
  ...paths: string                                   # Files or directories to search
  --files-only(-f)                                   # Skip AST parsing, output unique files
  --ignore(-i): string                               # Custom patterns to ignore
  --exclude-filenames(-n)                            # Exclude files whose names match query
  --reranker(-r): string@"nu-complete probe rerankers" # BM25 ranking for search results
  --frequency(-s)                                    # Use frequency-based search with stemming
  --exact(-e)                                        # Perform exact search without tokenization
  --max-results: int                                 # Maximum number of results to return
  --max-bytes: int                                   # Maximum total bytes of code content
  --max-tokens: int                                  # Maximum total tokens in code content
  --allow-tests                                      # Allow test files and test code blocks
  --no-merge                                         # Disable merging of adjacent code blocks
  --merge-threshold: int                             # Max lines between blocks for merging
  --dry-run                                          # Output only file names and line numbers
  --format(-o): string@"nu-complete probe formats"   # Output format
  --session: string                                  # Session ID for caching search results
  --timeout: int                                     # Timeout in seconds for search operation
  --help(-h)                                         # Print help
  --version(-V)                                      # Print version
]

def "nu-complete probe subcommands" [] {
  [
    'search',    # Search code using patterns with intelligent ranking
    'extract',   # Extract code blocks from files
    'query',     # Search code using AST patterns for structural matching
    'help'       # Print help message
  ]
}

# Probe search command
export extern "probe search" [
  pattern: string                                    # Search pattern (regex supported)
  ...paths: string                                   # Files or directories to search
  --files-only(-f)                                   # Skip AST parsing, output unique files
  --ignore(-i): string                               # Custom patterns to ignore
  --exclude-filenames(-n)                            # Exclude files whose names match query
  --reranker(-r): string@"nu-complete probe rerankers" # BM25 ranking for search results
  --frequency(-s)                                    # Use frequency-based search with stemming
  --exact(-e)                                        # Perform exact search without tokenization
  --language(-l): string@"nu-complete probe languages" # Programming language to limit search
  --max-results: int                                 # Maximum number of results to return
  --max-bytes: int                                   # Maximum total bytes of code content
  --max-tokens: int                                  # Maximum total tokens in code content
  --allow-tests                                      # Allow test files and test code blocks
  --no-merge                                         # Disable merging of adjacent code blocks
  --merge-threshold: int                             # Max lines between blocks for merging
  --dry-run                                          # Output only file names and line numbers
  --format(-o): string@"nu-complete probe search formats" # Output format
  --session: string                                  # Session ID for caching search results
  --timeout: int                                     # Timeout in seconds for search operation
  --help(-h)                                         # Print help
]

# Probe extract command
export extern "probe extract" [
  ...files: string                                   # Files to extract from (can include line numbers or symbols)
  --ignore(-i): string                               # Custom patterns to ignore
  --context(-c): int                                 # Number of context lines to include
  --format(-o): string@"nu-complete probe extract formats" # Output format
  --from-clipboard(-f)                               # Read input from clipboard instead of files
  --input-file(-F): string                           # Read input from a file
  --to-clipboard(-t)                                 # Write output to clipboard
  --dry-run                                          # Output only file names and line numbers
  --diff                                             # Parse input as git diff format
  --allow-tests                                      # Allow test files and test code blocks
  --keep-input(-k)                                   # Keep and display original input content
  --prompt: string@"nu-complete probe prompts"       # System prompt template for LLM models
  --instructions: string                             # User instructions for LLM models
  --help(-h)                                         # Print help
]

# Probe query command
export extern "probe query" [
  pattern: string                                    # AST pattern to search for
  path?: string                                      # Files or directories to search
  --language(-l): string@"nu-complete probe languages" # Programming language for parsing
  --ignore(-i): string                               # Custom patterns to ignore
  --allow-tests                                      # Allow test files in search results
  --max-results: int                                 # Maximum number of results to return
  --format(-o): string@"nu-complete probe query formats" # Output format
  --help(-h)                                         # Print help
]

# Probe help command
export extern "probe help" [
  command?: string@"nu-complete probe subcommands"   # Show help for specific subcommand
]