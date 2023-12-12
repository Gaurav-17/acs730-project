output "public_subnet_ids" {
  value = module.vpc-prod.public_subnet_id
}

output "private_subnet_ids" {
  value = module.vpc-prod.private_subnet_id
}


output "public_route_table" {
  value = module.vpc-prod.public_routetable_id
}


output "vpc_id" {
  value = module.vpc-prod.vpc_id
}