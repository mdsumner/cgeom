// We can now use the BH package
// [[Rcpp::depends(BH)]]

#include <Rcpp.h>
#include <boost/math/common_factor.hpp>  

using namespace Rcpp;

// [[Rcpp::export]]
int computeGCD(int a, int b) {
  return boost::math::gcd(a, b);
}

// [[Rcpp::export]]
int computeLCM(int a, int b) {
  return boost::math::lcm(a, b);
}
We can test these:
  
  a <- 6
b <- 15
cat( c(computeGCD(a,b), computeLCM(a,b)), "\n")
