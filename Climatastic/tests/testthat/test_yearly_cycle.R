library("testthat")

test_that("great yearly cycle (1)", {
  station <- 53878
  cycle <- yearly_cycle(station)
  
  expect_equal(
    cycle[1,2],
    4.9782609	
  )
  expect_equal(
    cycle[180,2],
    21.5818182	
  )
}
)

test_that("great yearly cycle (2)", {
  station <- 3739
  cycle <- yearly_cycle(station)
  
  expect_equal(
    cycle[1,2],
    7.557895	
  )
  expect_equal(
    cycle[180,2],
    24.805000	
  )
}
)

test_that("great yearly cycle (3)", {
  station <- 63849
  cycle <- yearly_cycle(station)
  
  expect_equal(
    cycle[1,2],
    4.390000		
  )
  expect_equal(
    cycle[180,2],
    23.805000	
  )
}
)

test_that("great yearly cycle (4)", {
  station <- 63838
  cycle <- yearly_cycle(station)
  
  expect_equal(
    cycle[1,2],
    3.476190e+00			
  )
  expect_equal(
    cycle[180,2],
    2.343810e+01
  )
}
)