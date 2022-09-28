terraform {
  required_version = ">= 1.0.0"

  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
}

module "main" {
  source = "../.."

  name = "LL1"
}

data "aci_rest_managed" "fabricHIfPol" {
  dn = "uni/infra/hintfpol-${module.main.name}"

  depends_on = [module.main]
}

resource "test_assertions" "fabricHIfPol" {
  component = "fabricHIfPol"

  equal "name" {
    description = "name"
    got         = data.aci_rest_managed.fabricHIfPol.content.name
    want        = module.main.name
  }
}
