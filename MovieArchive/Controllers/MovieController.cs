
using Microsoft.AspNetCore.Mvc;
using MovieArchive.Models;
using System.Text.Json;

namespace MovieArchive.Controllers
{
    public class MovieController : Controller
    {
        // Den ursprungliga filmsamlingen med åtta fördefinierade filmer
        private static readonly List<Movie> originalMovies = new()
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

        // Hämtar både ursprungliga och nytillagda filmer
        private List<Movie> GetMovies()
        {
            // Skapar en kopia av den ursprungliga filmsamlingen
            var movies = new List<Movie>(originalMovies);

            // Hämtar användarens sparade filmer från sessionen
            var savedMovies = HttpContext.Session.GetString("AddedMovies");

            // Kontrollerar om det finns sparade filmer
            if (!string.IsNullOrEmpty(savedMovies))
            {
                // Omvandlar sparad JSON-text till en lista med filmer
                var addedMovies = JsonSerializer.Deserialize<List<Movie>>(savedMovies);

                // Lägger till de sparade filmerna i filmsamlingen
                if (addedMovies != null)
                {
                    movies.AddRange(addedMovies);
                }
            }

            return movies;
        }

        // Hämtar och visar hela filmsamlingen på startsidan
        public IActionResult Index()
        {
            var movies = GetMovies();

            return View(movies);
        }

        // Visar formuläret för att lägga till en ny film
        [HttpGet]
        public IActionResult Create()
        {
            return View();
        }

        // Tar emot informationen som användaren skickar via formuläret
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create(Movie movie)
        {
            // Kontrollerar att titeln och utgivningsåret är giltiga
            if (string.IsNullOrWhiteSpace(movie.Title) ||
                movie.ReleaseYear < 1888 ||
                movie.ReleaseYear > DateTime.Now.Year + 5)
            {
                ModelState.AddModelError("",
                    "Please enter a valid movie title and release year.");

                return View(movie);
            }

            // Hämtar hela den befintliga filmsamlingen
            var movies = GetMovies();

            // Tilldelar den nya filmen ett unikt ID
            movie.Id = movies.Max(m => m.Id) + 1;

            // Hämtar tidigare tillagda filmer från sessionen
            var addedMoviesJson = HttpContext.Session.GetString("AddedMovies");

            // Skapar en ny lista om inga filmer har sparats tidigare
            // Annars omvandlas den sparade JSON-texten till en lista
            var addedMovies = string.IsNullOrEmpty(addedMoviesJson)
                ? new List<Movie>()
                : JsonSerializer.Deserialize<List<Movie>>(addedMoviesJson)
                  ?? new List<Movie>();

            // Lägger till den nya filmen i listan
            addedMovies.Add(movie);

            // Omvandlar listan till JSON och sparar den i sessionen
            HttpContext.Session.SetString(
                "AddedMovies",
                JsonSerializer.Serialize(addedMovies)
            );

            // Skickar den nya filmen till bekräftelsesidan
            return View("Confirmation", movie);
        }
    }
}


