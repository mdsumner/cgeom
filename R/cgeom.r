
vcrossp <- function( a, b ) {
  cbind(a[,2] * b[,3] - a[,3] * b[,2],
        a[,3] * b[,1] - a[,1] * b[,3],
        a[,1] * b[,2] - a[,2] * b[,1])
}

library(rbenchmark)

benchmark(vcrossp(pts[-1, ], pts[-nrow(pts), ]), vcrossp1(pts[-1, ], pts[-nrow(pts), ]),  replications = 10000)


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

vecrize <- TRUE
set.seed(1)
pts <- cbind(matrix(rnorm(150) , ncol = 2), 0)


plot(pts)
system.time({
  edges <- t(combn(seq(nrow(pts)), 2))
  edgetest <- logical(nrow(edges))

  for (ie in seq(nrow(edges))) {
    edge <- pts[edges[ie, ], ]
    #lines(edge, col = rgb(1, 0, 0, 0.3))
    kpts <- setdiff(seq(nrow(pts)), edges[ie, ])
    if (vecrize) {

      test <- SameSide(pts[kpts[-1], , drop = FALSE], pts[kpts[-length(kpts)], , drop = FALSE],
                       edge[1, , drop = FALSE], edge[2, , drop = FALSE])
    } else {
      test <- TRUE
      for (k in seq(length(kpts) -1)) {
        test <- test && SameSide(pts[kpts[k], , drop = FALSE], pts[kpts[k + 1], , drop = FALSE],
                                 edge[1, , drop = FALSE], edge[2, , drop = FALSE])
      }

    }
    if (all(test)) {
      edgetest[ie] <- TRUE
      #lines(edge, lty =2, lwd = 3)
    }

  }

})

apply(edges[edgetest, ], 1, function(x) lines(pts[x, ], lwd = 4))
