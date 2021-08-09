terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

module "main" {
  source = "../.."

  name = "LL1"
}

data "aci_rest" "fabricHIfPol" {
  dn = "uni/infra/hintfpol-${module.main.name}"

  depends_on = [module.main]
}

resource "test_assertions" "fabricHIfPol" {
  component = "fabricHIfPol"

  equal "name" {
    description = "name"
    got         = data.aci_rest.fabricHIfPol.content.name
    want        = module.main.name
  }
}
