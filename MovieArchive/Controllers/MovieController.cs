
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
                new Movie { Id = 4, Title = "Don't Look Up", ReleaseYear = 2021 },
                new Movie { Id = 5, Title = "American Hustle", ReleaseYear = 2013 },
                new Movie { Id = 6, Title = "A Star is Born", ReleaseYear = 2018 },
                new Movie { Id = 7, Title = "Divergent", ReleaseYear = 2014 },
                new Movie { Id = 8, Title = "The Fault in our Stars", ReleaseYear = 2014 }
            };

            return View(movies);
        }

        // Visar formuläret för att lägga till en film
        [HttpGet]
        public IActionResult Create()
        {
            return View();
        }

        // Tar emot informationen från formuläret
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create(Movie movie)
        {
            if (string.IsNullOrWhiteSpace(movie.Title) ||
                movie.ReleaseYear < 1850 ||
                movie.ReleaseYear > DateTime.Now.Year + 5)
            {
                ModelState.AddModelError("", "Please enter a valid movie title and release year.");
                return View(movie);
            }

            return View("Confirmation", movie);
        }
    }
}

