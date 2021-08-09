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

  name     = "100G"
  speed    = "100G"
  auto     = false
  fec_mode = "disable-fec"
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

  equal "speed" {
    description = "speed"
    got         = data.aci_rest.fabricHIfPol.content.speed
    want        = "100G"
  }

  equal "autoNeg" {
    description = "autoNeg"
    got         = data.aci_rest.fabricHIfPol.content.autoNeg
    want        = "off"
  }

  equal "fecMode" {
    description = "fecMode"
    got         = data.aci_rest.fabricHIfPol.content.fecMode
    want        = "disable-fec"
  }
}
