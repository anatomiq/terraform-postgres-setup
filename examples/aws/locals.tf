locals {
  tags = merge(
    var.tags,
    {
      environment = var.environment
      iac         = "terraform"
    }
  )
}
