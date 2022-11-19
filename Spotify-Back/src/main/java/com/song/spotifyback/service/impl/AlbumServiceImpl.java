package com.song.spotifyback.service.impl;


import com.song.spotifyback.entity.Album;
import com.song.spotifyback.repository.AlbumRepository;
import com.song.spotifyback.service.AlbumService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class AlbumServiceImpl implements AlbumService {
    @Autowired
    private final AlbumRepository albumRepository;

    @Override
    public List<Album> getAllAlbums() {
        return albumRepository.findAll();
    }

    @Override
    public List<Album> getAllAlbumsByArtistId(final Long artistId) {
        return albumRepository.findByArtistId(artistId);
    }

    @Override
    public Album getAlbumById(final Long albumId) throws Exception {
        return albumRepository.findById(albumId).orElseThrow(() -> new Exception("Album doesn't exist"));
    }
//    @Transactional
//    public List<Album> get(){
//        return albumRepository.findAll();
//    }
}
