
using Microsoft.AspNetCore.Mvc;
using MovieArchive.Models;

namespace MovieArchive.Controllers
{
    public class MovieController : Controller
    {
        public IActionResult Index()
        {
            var movies = new List<Movie>
            {
                new Movie { Id = 1, Title = "The Hunger Games", ReleaseYear = 2012 },
                new Movie { Id = 2, Title = "Titanic", ReleaseYear = 1997 },
                new Movie { Id = 3, Title = "Inception", ReleaseYear = 2010 },
                new Movie { Id = 3, Title = "Don't Look Up", ReleaseYear = 2021 },
                new Movie { Id = 3, Title = "American Hustle", ReleaseYear = 2013 },
                new Movie { Id = 3, Title = "A Star is Born", ReleaseYear = 2018 },
                new Movie { Id = 3, Title = "Divergent", ReleaseYear = 2014 },
                new Movie { Id = 3, Title = "The Fault in our Stars", ReleaseYear = 2014 }
            };

            return View(movies);
        }
    }
}
