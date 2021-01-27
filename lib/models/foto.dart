class Foto {
  final int fecha;
  final String foto_id;
  final String fotografo_id;
  final String s3_key;
  final String url_foto;
  final String url_thumbnail;

  Foto(
      {this.foto_id,
      this.fecha,
      this.s3_key,
      this.url_thumbnail,
      this.url_foto,
      this.fotografo_id});
}
