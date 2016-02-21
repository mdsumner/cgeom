
vcrossp <- function(a, b) {
  cbind(a[,2] * b[,3] - a[,3] * b[,2],
        a[,3] * b[,1] - a[,1] * b[,3],
        a[,1] * b[,2] - a[,2] * b[,1])
}


mkm <- function(x, n) {
  #if (length(x) == 2) x <- c(x, 0)
  matrix(x, nrow = n, ncol = 3,  byrow = TRUE)
}


SameSide <- function(p1,p2, a,b) {
  a <- mkm(a, nrow(p1))
  b <- mkm(b, nrow(p1))
  cp2 = vcrossp(b-a, p2-a)
  cp1 = vcrossp(b-a, p1- a)
  c(cp1 %*% t(cp2)) >= 0
}

vlen <- function(x) {
  sqrt(diff(x[, 1])^2 + diff(x[, 2])^2 + diff(x[, 3])^2)
}
angle <- function(x) {
  x1 <- x[1,] - x[2,]
  x2 <- x[1,] - x[3,]
  a <- (atan2(x1[2], x1[1]) - atan2(x2[2], x2[1]))
  if (a < -pi) a<- a + 2*pi
  if (a > pi) a <- a- 2*pi
  a
}
turnright <- function(x) {
  !angle(x) < 0
}
