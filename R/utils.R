#' @rdname utilities
#' @title Utility Functions
#' @description Some utility functions for working with S3 objects and buckets
#' @param x An object.
#' @param \dots Ignored.
#' @return \code{get_bucketname} returns a character string.
#' @export
get_bucketname <- function(x, ...) {
    UseMethod("get_bucketname")
}

#' @rdname utilities
#' @export
get_bucketname.character <- function(x, ...) {
    x
}

#' @rdname utilities
#' @export
get_bucketname.s3_bucket <- function(x, ...) {
    attributes(x)[["Name"]]
}

#' @rdname utilities
#' @export
get_bucketname.s3_object <- function(x, ...) {
    x[["Bucket"]]
}


# get_region

get_region <- function(x, ...) {
    UseMethod("get_region")
}

get_region.default <- function(x, ...) {
    NULL
}

get_region.s3_bucket <- function(x, ...) {
    attributes(x)[["x-amz-bucket-region"]]
}


# get_objectkey
get_objectkey <- function(x, ...) {
    UseMethod("get_objectkey")
}

get_objectkey.character <- function(x, ...) {
    gsub("^/{1}", "", x)
}

get_objectkey.s3_object <- function(x, ...) {
    gsub("^/{1}", "", x[["Key"]])
}



flatten_list <- function(x) {
    if (is.list(x)) {
        if ((class(x) != "list") || (length(class(x)) > 1)) {
            return(x)
        } else {
            if (length(x) == 1) {
                return(flatten_list(x[[1]]))
            } else {
                return(lapply(x, flatten_list))
            }
        }
    } else {
        return(x)
    }
}
