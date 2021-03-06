\name{AtcDb-class}
\Rdversion{1.1}
\docType{class}
\alias{AtcDb-class}
\alias{AtcDb}
\alias{show,AtcDb-method}
\alias{dbconn,AtcDb-method}
\alias{keys,AtcDb-method}
\alias{as.data.frame,AtcDb-method}
\alias{atcData}
\alias{atcs}
\alias{atcs,AtcDb-method}
\alias{listTables,AtcDb-method}
\alias{listColumns,AtcDb-method}
\alias{atcData,AtcDb-method}
\alias{columns}
\alias{columns,AtcDb-method}

\title{Anatomical Therapeutic Chemical Data}

\description{
  The \code{AtcDb} provides the data from the Anatomical Therapeutic
  Chemical (ATC) Classification System as defined by the WHOCC (WHO
  Collaborating Centre for Drug Statistics Methodology).

  In this system, drugs are classified into groups at 5 different
  levels:

  \describe{

    \item{First level}{
      Indicates the anatomical main group and consists of one letter
      (e.g. \emph{C} for \emph{cardiovascular system}).
    }

    \item{Second level}{
      Indicates the therapeutic main group and consists of two digits
      (e.g. \emph{C03} for \emph{diuretic drugs}. Note that the digits
      \emph{03} have another meaning in another level, i.e. \emph{D03}
      stands for \emph{Treatment of wounds and ulcers}).
    }

    \item{Third level}{
      Indicates the therapeutic/pharmacological subgroup and consists of
      one letter (e.g. \emph{C03C} for \emph{High-ceiling diuretics}).
    }

    \item{Fourth level}{
      indicates the chemical/therapeutic/pharmacological subgroup and
      consists of one letter (e.g. \emph{C03CA} for
      \emph{Sulfonamides}).
    }

    \item{Fifth level}{
      The fifth level indicates the chemical substance and consists of
      two digits (e.g. \emph{C03CA01} for \emph{Furosemide}).
    }
  }
}

\section{Objects of the class}{
  \code{AtcDb} objects are created by the constructor function
  \code{AtcDb}. The database is automatically loaded on package startup
  and the \code{AtcDb} object providing access to the data is available
  through the \code{atc} variable. Thus, there should be no need to load
  or instatiate such an object manually.
}
\usage{

\S4method{as.data.frame}{AtcDb}(x, row.names=NULL, optional=FALSE, ...)

%\S4method{atcData}{AtcDb}(x, columns, key, level, pattern)

\S4method{atcs}{AtcDb}(x, columns=listColumns(x), filter=AnnotationFilterList(),
order.by="key", ...)

\S4method{columns}{AtcDb}(x)

\S4method{dbconn}{AtcDb}(x)

\S4method{keys}{AtcDb}(x, level, ...)

\S4method{listColumns}{AtcDb}(x)

\S4method{listTables}{AtcDb}(x, ...)

}
\arguments{

  (in alphabetic order)

  \item{columns}{
    A character vector specifying the columns that should be
    returned. Use the \code{columns} or \code{listColumns} method to
    list all allowed column names.
  }

  \item{filter}{
    Either a single filter object or a \code{list} of filter object to
    filter the results retrieved from the database. See
    \code{\link{KeyFilter}} for a list of supported filters.
  }

  \item{key}{
    A character vector of ATC code(s). Use method \code{keys} to
    retrieve all ATC codes stored in the database.
  }

  \item{level}{
    A numeric vector specifying the ATC code level(s) (from 1 to 5) that
    should be retrieved from the database.
  }

  \item{optional}{
    For \code{as.data.frame}: not used.
  }

  \item{order.by}{
    For \code{atcs}: the column by which the results should be ordered.
  }

  %% \item{pattern}{
  %%   A character vector of possible key words that are searched in the
  %%   ATC names attribute. Note that a case insensitive pattern matching
  %%   is performed on this keyword (or keywords).
  %% }

  \item{row.names}{
    For \code{as.data.frame}: not used.
  }

  \item{x}{
    The \code{AtcDb} object.
  }

  \item{...}{
    Presently not used.
  }

}
\section{Slots}{
  \describe{
    \item{atcdb}{
      The connection to the internal SQLite database.
    }

    \item{.properties}{
      Internal list to be used to set/specify properties. Not used at
      present.
    }

    \item{tables}{
      \code{list} providing the available column names in each table
      (names being the table names, elements the column/attribute
      names).
    }

  }
}

\details{
  For details on the database tables and the columns please refer to the
  Vignette. Note that the defined daily dose (\emph{ddd}) is only
  available for level 5 codes, and that each of these can have several
  different ddds.

  The \emph{main} columns are:
  \describe{

    \item{key}{
      The ATC code of the entry.
    }

    \item{name}{
      The english name of the entry.
    }

    \item{level}{
      The ATC level of the entry (1 to 5).
    }

    \item{ddd}{
      (Only for level 5 entries): the defined daily doses. This may not
      be defined for all drugs.
    }

    \item{unit}{
      The unit of the dose in \emph{ddd}.
    }

    \item{administration_route}{
      The route of administration for the drug.
    }

    \item{note}{
      Eventual additional information related to the ddd.
    }
  }
}

\section{Basic usage}{

  (in alphabetic order)

  \describe{
    \item{as.data.frame}{
      Extract the full ATC data from the database and return it as
      \code{data.frame}.
    }

    \item{atcData}{
      This method is deprecated; please use \code{atcs} instead which
      provides much more flexibility.

      Retrieve data from the database. This method allows to query
      either the full data from the database (if called without
      additional arguments) or allows to search and retrieve specific
      information, e.g. ATC data from specified ATC levels or ATC data
      where the name matches the supplied pattern.
      The method returns a \code{data.frame} with the columns specified
      by the argument \code{columns} or (by default) all columns.
    }

    \item{atcs}{
      Retrieve data from the database. Arguments \code{columns} and
      \code{filter} allow to specify which columns and entries should be
      fetched from the database.
    }

    \item{columns}{
      Returns a character vector with the column names of the database
      tables.
    }

    \item{dbconn}{
      Returns the connection to the internal (RSQLite) database.
    }

    \item{keys}{
      Returns a character vector of all ATC codes in the database, or
      ATC codes of the level(s) that was/were specified with argument
      \code{level}.
    }

    \item{listTables}{
      Returns a \code{list} of column names in each table. The names of
      the list correspond to the table names.
    }
  }
}

\value{
  Refer to the method and function description above for detailed
  information on the returned result object.
}
\references{
  The WHO Collaborating Centre for Drug Statistics Methodology, Oslo,
  Norway (\url{http://www.whocc.no}).
}
\author{
  Johannes Rainer.
}
\examples{

## Display some information on the database.
atc

## List all columns in the database.
columns(atc)

## List tables and columns.
listTables(atc)

## Extract the full data as data.frame.
tmp <- as.data.frame(atc)
head(tmp)

## Get all the ATC codes of level 1.
keys(atc, level=1)

## Get all data for ATC codes of level 1
atcs(atc, filter=LevelFilter(1))
##atcData(atc, level=1)

## Get all data for ATC codes of level 2:4
## tmp <- atcData(atc, level=2:4)
atcs(atc, filter=LevelFilter(2:4))

## Get all data containing "cardio" or "kidney" in the name
##atcData(atc, pattern=c("cardio", "renal"), level=1:3)


## Use filters instead.
atcs(atc, filter=LevelFilter(1:3))

## See the vignette for more examples.


}
\keyword{classes}

