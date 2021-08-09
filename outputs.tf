output "dn" {
  value       = aci_rest.fabricHIfPol.id
  description = "Distinguished name of `fabricHIfPol` object."
}

output "name" {
  value       = aci_rest.fabricHIfPol.content.name
  description = "Link level interface policy name."
}
