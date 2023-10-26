terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      # version = "4.27.0"
    }
    google-beta = {
      source = "hashicorp/google-beta"
      # version = "4.27.0"
    }
    # helm = {
    #   source = "hashicorp/helm"
    # }
    # local = {
    #   source = "hashicorp/local"
    # }
    # googleworkspace = {
    #   source = "hashicorp/googleworkspace"
    #   # version = ">= 0.7.0"
    # }
    # github = {
    #   source = "integrations/github"
    #   # version = "5.5.0"
    # }
  }
}
