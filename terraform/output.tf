output "vpc_id" {
  value = aws_vpc.vc.id
}

output "public_subnet_ids" {
  value = aws_subnet.vc_public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.vc_private[*].id
}
