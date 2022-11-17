package com.song.spotifyback.service;

import com.song.spotifyback.entity.Album;

import java.util.List;

public interface AlbumService {
    public List<Album> getAllAlbums();
//    public List<Album> getAllAlbumsByMusic();
    public List<Album> getAllAlbumsByArtistId(final Long artistId);

}
