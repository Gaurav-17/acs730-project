# Step 10 - Add output variables
output "web_sg_public" {
  value = aws_security_group.web_sg_public.id
}