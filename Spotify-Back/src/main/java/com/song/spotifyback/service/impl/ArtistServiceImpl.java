package com.song.spotifyback.service.impl;

import com.song.spotifyback.repository.ArtistRepository;
import com.song.spotifyback.service.ArtistService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ArtistServiceImpl implements ArtistService {
    @Autowired
    private final ArtistRepository artistRepository;

//
//    @Transactional
//    public List<Artist> findAllArtists(){
//        return this.artistRepository.findAll();
//    }
}
