# Google Cloud SDK (gcloud) completions for Nushell
# https://cloud.google.com/sdk

# Helper function to get gcloud projects
def "nu-complete gcloud projects" [] {
  try {
    ^gcloud projects list --format="value(projectId)" | lines
  } catch {
    []
  }
}

# Helper function to get gcloud configurations
def "nu-complete gcloud configurations" [] {
  try {
    ^gcloud config configurations list --format="value(name)" | lines
  } catch {
    []
  }
}

# Helper function to get gcloud accounts
def "nu-complete gcloud accounts" [] {
  try {
    ^gcloud auth list --format="value(account)" | lines
  } catch {
    []
  }
}

# Helper function for verbosity levels
def "nu-complete gcloud verbosity" [] {
  ['debug', 'info', 'warning', 'error', 'critical', 'none']
}

# Helper function for output formats
def "nu-complete gcloud formats" [] {
  ['config', 'csv', 'default', 'diff', 'disable', 'flattened', 'get', 'json', 'list', 'multi', 'none', 'object', 'table', 'text', 'value', 'yaml']
}

# Helper function for compute zones
def "nu-complete gcloud zones" [] {
  try {
    ^gcloud compute zones list --format="value(name)" | lines
  } catch {
    []
  }
}

# Helper function for compute regions
def "nu-complete gcloud regions" [] {
  try {
    ^gcloud compute regions list --format="value(name)" | lines
  } catch {
    []
  }
}

# Helper function for compute instances
def "nu-complete gcloud instances" [] {
  try {
    ^gcloud compute instances list --format="value(name)" | lines
  } catch {
    []
  }
}

# Helper function for compute machine types
def "nu-complete gcloud machine-types" [] {
  try {
    ^gcloud compute machine-types list --format="value(name)" | lines | first 50
  } catch {
    []
  }
}

# Helper function for storage buckets
def "nu-complete gcloud buckets" [] {
  try {
    ^gcloud storage buckets list --format="value(name)" | lines
  } catch {
    []
  }
}

# Main gcloud command completions
export extern "gcloud" [
  command?: string@"nu-complete gcloud subcommands"   # Gcloud command or group
  --help(-h)                                          # Display help
  --version(-v)                                       # Print version information
  --account: string@"nu-complete gcloud accounts"     # Google Cloud user account
  --billing-project: string@"nu-complete gcloud projects" # Billing project
  --configuration: string@"nu-complete gcloud configurations" # Configuration name
  --flags-file: string                                # YAML/JSON file with flags
  --flatten: string                                   # Flatten output resource slices
  --format: string@"nu-complete gcloud formats"       # Output format
  --project: string@"nu-complete gcloud projects"     # Google Cloud project ID
  --quiet(-q)                                         # Disable interactive prompts
  --verbosity: string@"nu-complete gcloud verbosity"  # Verbosity level
  --access-token-file: string                         # Access token file path
  --impersonate-service-account: string               # Service account to impersonate
  --log-http                                          # Log HTTP requests/responses
  --trace-token: string                               # Trace token for debugging
  --no-user-output-enabled                            # Disable user output
]

def "nu-complete gcloud subcommands" [] {
  [
    # Groups
    'access-approval',      # Manage Access Approval requests
    'access-context-manager', # Manage Access Context Manager
    'active-directory',     # Manage Managed Microsoft AD
    'ai',                   # Manage Vertex AI entities
    'ai-platform',          # Manage AI Platform jobs and models
    'alloydb',              # Create and manage AlloyDB databases
    'alpha',                # Alpha versions of gcloud commands
    'anthos',               # Anthos command group
    'api-gateway',          # Manage Cloud API Gateway
    'apigee',               # Manage Apigee resources
    'app',                  # Manage App Engine deployments
    'apphub',               # Manage App Hub resources
    'artifacts',            # Manage Artifact Registry
    'asset',                # Manage Cloud Asset Inventory
    'assured',              # Assured Workloads data controls
    'audit-manager',        # Audit workloads and generate reports
    'auth',                 # Manage oauth2 credentials
    'backup-dr',            # Manage Backup and DR resources
    'batch',                # Manage Batch resources
    'beta',                 # Beta versions of gcloud commands
    'bigtable',             # Manage Cloud Bigtable storage
    'billing',              # Manage billing accounts
    'bms',                  # Manage Bare Metal Solution
    'bq',                   # Manage Bq resources
    'builds',               # Create and manage builds
    'certificate-manager',  # Manage SSL certificates
    'cloud-shell',          # Manage Google Cloud Shell
    'colab',                # Manage Colab Enterprise
    'components',           # Manage CLI components
    'composer',             # Create and manage Cloud Composer
    'compute',              # Create and manipulate Compute Engine
    'config',               # View and edit CLI properties
    'container',            # Deploy and manage container clusters
    'data-catalog',         # Manage Data Catalog resources
    'database-migration',   # Manage Database Migration Service
    'dataflow',             # Manage Google Cloud Dataflow
    'dataplex',             # Manage Dataplex resources
    'dataproc',             # Create and manage Dataproc clusters
    'datastore',            # Manage Cloud Datastore resources
    'datastream',           # Manage Cloud Datastream resources
    'deploy',               # Create and manage Cloud Deploy
    'deployment-manager',   # Manage deployments of cloud resources
    'developer-connect',    # Manage Developer Connect resources
    'dns',                  # Manage Cloud DNS managed-zones
    'domains',              # Manage domains for projects
    'edge-cache',           # Manage Media CDN resources
    'edge-cloud',           # Manage edge-cloud resources
    'emulators',            # Set up local development environment
    'endpoints',            # Create, enable and manage API services
    'essential-contacts',   # Manage Essential Contacts
    'eventarc',             # Manage Eventarc resources
    'filestore',            # Create and manipulate Filestore
    'firebase',             # Work with Google Firebase
    'firestore',            # Manage Cloud Firestore resources
    'functions',            # Manage Google Cloud Functions
    'gemini',               # Manage code repository index
    'healthcare',           # Manage Cloud Healthcare resources
    'iam',                  # Manage IAM service accounts and keys
    'iap',                  # Manage IAP policies
    'identity',             # Manage Cloud Identity Groups
    'ids',                  # Manage Cloud IDS
    'immersive-stream',     # Manage Immersive Stream resources
    'infra-manager',        # Manage Infra Manager resources
    'kms',                  # Manage cryptographic keys
    'logging',              # Manage Cloud Logging
    'looker',               # Manage Looker resources
    'lustre',               # Manage Lustre resources
    'managed-kafka',        # Administer Managed Service for Apache Kafka
    'memcache',             # Manage Cloud Memorystore Memcached
    'memorystore',          # Manage Memorystore resources
    'metastore',            # Manage Dataproc Metastore resources
    'migration',            # Cloud Migration teams
    'ml',                   # Use Google Cloud machine learning
    'ml-engine',            # Manage AI Platform jobs and models
    'model-armor',          # Model Armor LLM security
    'monitoring',           # Manage Cloud Monitoring dashboards
    'netapp',               # Create and manipulate Cloud NetApp Files
    'network-connectivity', # Manage Network Connectivity Center
    'network-management',   # Manage Network Management resources
    'network-security',     # Manage Network Security resources
    'network-services',     # Manage Network Services resources
    'notebooks',            # Notebooks Command Group
    'observability',        # Manage Observability resources
    'oracle-database',      # Manage Oracle Database resources
    'org-policies',         # Create and manage Organization Policies
    'organizations',        # Create and manage Organizations
    'pam',                  # Manage Privileged Access Manager
    'parametermanager',     # Parameter Manager
    'policy-intelligence',  # Platform to manage policies at scale
    'policy-troubleshoot',  # Troubleshoot policies
    'privateca',            # Manage private Certificate Authorities
    'projects',             # Create and manage project access policies
    'publicca',             # Manage accounts for Google Trust Services
    'pubsub',               # Manage Cloud Pub/Sub
    'recaptcha',            # Manage reCAPTCHA Enterprise Keys
    'recommender',          # Manage Cloud recommendations
    'redis',                # Manage Cloud Memorystore Redis
    'resource-manager',     # Manage Cloud Resources
    'run',                  # Manage Cloud Run applications
    'scc',                  # Manage Cloud SCC resources
    'scheduler',            # Manage Cloud Scheduler jobs
    'secrets',              # Manage secrets on Google Cloud
    'service-directory',    # Service Directory command groups
    'service-extensions',   # Manage Service Extensions resources
    'services',             # List, enable and disable APIs and services
    'source',               # Cloud git repository commands
    'spanner',              # Command groups for Cloud Spanner
    'sql',                  # Create and manage Cloud SQL databases
    'storage',              # Create and manage Cloud Storage
    'tasks',                # Manage Cloud Tasks queues and tasks
    'telco-automation',     # Manage Telco Automation resources
    'topic',                # gcloud supplementary help
    'transcoder',           # Manage Transcoder jobs and templates
    'transfer',             # Manage Transfer Service jobs
    'vmware',               # Manage Google Cloud VMware Engine
    'workbench',            # Workbench Command Group
    'workflows',            # Manage Cloud Workflows resources
    'workspace-add-ons',    # Manage Google Workspace Add-ons
    'workstations',         # Manage Cloud Workstations resources
    
    # Commands
    'cheat-sheet',          # Display gcloud cheat sheet
    'docker',               # Enable Docker CLI access to Container Registry
    'feedback',             # Provide feedback to the team
    'help',                 # Search gcloud help text
    'info',                 # Display information about environment
    'init',                 # Initialize or reinitialize gcloud
    'survey',               # Invoke customer satisfaction survey
    'version'               # Print version information
  ]
}

# Gcloud compute command
export extern "gcloud compute" [
  subcommand?: string@"nu-complete gcloud compute subcommands" # Compute subcommand
  --help                                          # Display help
  --project: string@"nu-complete gcloud projects" # Project ID
  --zone: string@"nu-complete gcloud zones"       # Compute zone
  --region: string@"nu-complete gcloud regions"   # Compute region
  --format: string@"nu-complete gcloud formats"   # Output format
  --quiet(-q)                                     # Disable prompts
]

def "nu-complete gcloud compute subcommands" [] {
  [
    'instances',            # Manage VM instances
    'instance-groups',      # Manage instance groups
    'instance-templates',   # Manage instance templates
    'disks',                # Manage persistent disks
    'snapshots',            # Manage disk snapshots
    'images',               # Manage custom images
    'machine-types',        # Display machine types
    'zones',                # Display zones
    'regions',              # Display regions
    'networks',             # Manage VPC networks
    'subnets',              # Manage subnets
    'firewall-rules',       # Manage firewall rules
    'routes',               # Manage routes
    'addresses',            # Manage static IP addresses
    'forwarding-rules',     # Manage forwarding rules
    'target-pools',         # Manage target pools
    'backend-services',     # Manage backend services
    'health-checks',        # Manage health checks
    'http-health-checks',   # Manage HTTP health checks
    'https-health-checks',  # Manage HTTPS health checks
    'url-maps',             # Manage URL maps
    'target-http-proxies',  # Manage target HTTP proxies
    'target-https-proxies', # Manage target HTTPS proxies
    'ssl-certificates',     # Manage SSL certificates
    'operations',           # Display operations
    'project-info',         # Display project information
    'ssh',                  # SSH into VM instances
    'scp',                  # Copy files to/from VM instances
    'reset-windows-password' # Reset Windows VM password
  ]
}

# Gcloud compute instances command
export extern "gcloud compute instances" [
  subcommand?: string@"nu-complete gcloud compute instances subcommands" # Instances subcommand
  --help                                          # Display help
  --project: string@"nu-complete gcloud projects" # Project ID
  --zone: string@"nu-complete gcloud zones"       # Compute zone
  --format: string@"nu-complete gcloud formats"   # Output format
  --quiet(-q)                                     # Disable prompts
]

def "nu-complete gcloud compute instances subcommands" [] {
  ['list', 'describe', 'create', 'delete', 'start', 'stop', 'reset', 'add-tags', 'remove-tags', 'set-machine-type', 'attach-disk', 'detach-disk']
}

# Gcloud compute instances create command
export extern "gcloud compute instances create" [
  ...instance_names: string                       # Instance names
  --machine-type: string@"nu-complete gcloud machine-types" # Machine type
  --zone: string@"nu-complete gcloud zones"       # Compute zone
  --image: string                                 # Image name
  --image-family: string                          # Image family
  --image-project: string                         # Image project
  --boot-disk-size: string                        # Boot disk size
  --boot-disk-type: string                        # Boot disk type
  --subnet: string                                # Subnet name
  --network: string                               # Network name
  --address: string                               # Static IP address
  --no-address                                    # Don't assign external IP
  --tags: string                                  # Network tags (comma-separated)
  --preemptible                                   # Create preemptible instance
  --spot                                          # Create Spot VM instance
  --maintenance-policy: string                    # Maintenance policy
  --restart-on-failure                            # Restart on failure
  --no-restart-on-failure                        # Don't restart on failure
  --metadata: string                              # Metadata key-value pairs
  --metadata-from-file: string                    # Metadata from file
  --scopes: string                                # Service account scopes
  --service-account: string                       # Service account email
  --no-service-account                            # Don't use service account
  --help                                          # Display help
]

# Gcloud storage command
export extern "gcloud storage" [
  subcommand?: string@"nu-complete gcloud storage subcommands" # Storage subcommand
  --help                                          # Display help
  --project: string@"nu-complete gcloud projects" # Project ID
  --format: string@"nu-complete gcloud formats"   # Output format
  --quiet(-q)                                     # Disable prompts
]

def "nu-complete gcloud storage subcommands" [] {
  ['buckets', 'objects', 'cp', 'mv', 'rm', 'ls', 'du', 'cat', 'compose', 'rewrite', 'rsync']
}

# Gcloud storage buckets command
export extern "gcloud storage buckets" [
  subcommand?: string@"nu-complete gcloud storage buckets subcommands" # Buckets subcommand
  --help                                          # Display help
  --project: string@"nu-complete gcloud projects" # Project ID
  --format: string@"nu-complete gcloud formats"   # Output format
]

def "nu-complete gcloud storage buckets subcommands" [] {
  ['list', 'describe', 'create', 'delete', 'update', 'add-iam-policy-binding', 'remove-iam-policy-binding', 'get-iam-policy', 'set-iam-policy']
}

# Gcloud auth command
export extern "gcloud auth" [
  subcommand?: string@"nu-complete gcloud auth subcommands" # Auth subcommand
  --help                                          # Display help
]

def "nu-complete gcloud auth subcommands" [] {
  [
    'list',                   # List credentialed accounts
    'login',                  # Authorize gcloud to access Cloud Platform
    'logout',                 # Revoke access credentials
    'revoke',                 # Revoke access credentials
    'activate-service-account', # Authorize access with service account
    'configure-docker',       # Configure Docker to use gcloud
    'print-access-token',     # Print access token for account
    'print-identity-token',   # Print identity token for account
    'application-default'     # Manage Application Default Credentials
  ]
}

# Gcloud config command
export extern "gcloud config" [
  subcommand?: string@"nu-complete gcloud config subcommands" # Config subcommand
  --help                                          # Display help
]

def "nu-complete gcloud config subcommands" [] {
  [
    'list',                   # List properties
    'get-value',              # Print value of property
    'set',                    # Set property
    'unset',                  # Unset property
    'configurations'          # Manage configurations
  ]
}

# Gcloud projects command
export extern "gcloud projects" [
  subcommand?: string@"nu-complete gcloud projects subcommands" # Projects subcommand
  --help                                          # Display help
  --format: string@"nu-complete gcloud formats"   # Output format
]

def "nu-complete gcloud projects subcommands" [] {
  ['list', 'describe', 'create', 'delete', 'undelete', 'get-iam-policy', 'set-iam-policy', 'add-iam-policy-binding', 'remove-iam-policy-binding']
}

# Gcloud container command
export extern "gcloud container" [
  subcommand?: string@"nu-complete gcloud container subcommands" # Container subcommand
  --help                                          # Display help
  --project: string@"nu-complete gcloud projects" # Project ID
  --zone: string@"nu-complete gcloud zones"       # Compute zone
  --region: string@"nu-complete gcloud regions"   # Compute region
]

def "nu-complete gcloud container subcommands" [] {
  [
    'clusters',               # Manage GKE clusters
    'node-pools',             # Manage GKE node pools
    'operations',             # Display operations
    'get-server-config',      # Get server config
    'images'                  # Manage container images
  ]
}

# Gcloud services command
export extern "gcloud services" [
  subcommand?: string@"nu-complete gcloud services subcommands" # Services subcommand
  --help                                          # Display help
  --project: string@"nu-complete gcloud projects" # Project ID
]

def "nu-complete gcloud services subcommands" [] {
  ['list', 'enable', 'disable', 'operations', 'vpc-peerings']
}

# Gcloud iam command
export extern "gcloud iam" [
  subcommand?: string@"nu-complete gcloud iam subcommands" # IAM subcommand
  --help                                          # Display help
  --project: string@"nu-complete gcloud projects" # Project ID
]

def "nu-complete gcloud iam subcommands" [] {
  [
    'service-accounts',       # Manage service accounts
    'roles',                  # Manage IAM roles
    'policies',               # Manage IAM policies
    'workload-identity-pools', # Manage workload identity pools
    'workforce-pools'         # Manage workforce pools
  ]
}