using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication23
{
    public class fakture
    {

        private int id;
        private string oznaka;
        private string korisnik;
        private string artikal;
        private int kolicina;
        private int iznos;
        private DateTime datum;
        private string prodavnica;

        public int Id { get => id; set => id = value; }
        public string Oznaka { get => oznaka; set => oznaka = value; }
        public string Korisnik { get => korisnik; set => korisnik = value; }
        public string Artikal { get => artikal; set => artikal = value; }
        public int Kolicina { get => kolicina; set => kolicina = value; }
        public int Iznos { get => iznos; set => iznos = value; }
        public DateTime Datum { get => datum; set => datum = value; }
        public string Prodavnica { get => prodavnica; set => prodavnica = value; }

        public fakture(int id)
        {
            id = Id;
        }

    }
}